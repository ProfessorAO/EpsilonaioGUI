
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');
import * as use from '@tensorflow-models/universal-sentence-encoder';
import * as tf from '@tensorflow/tfjs-node';



  export function tokenize(str) {
    return str.match(/\b\w+\b/g);
  }

  export function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }
  export async function getInnerTxt(page) {
    return await page.evaluate(() => {
      return JSON.parse(document.querySelector("body").textContent);
    });
  }
  
  export async function closePopupIfExists(page, selector) {
    if (await page.$(selector)){
      console.log('popup');
      await sleep(2000);
      await page.keyboard.press('Escape');

    }else if(await page.$(".recommendation-modal__container")){
      console.log('pop up');
      await page.waitForSelector('.recommendation-modal__container', { visible: true });
      await page.evaluate(() => {
        const container = document.querySelector('.recommendation-modal__button');
        if (container) {
          container.click();
        }
      });
      console.log('clicked');
      await sleep(2000);
      
      
    }else{
      console.log('pop up not in DOM');
    }
    
  }
  
  export function getPositiveAndNegativeKeywords(keywords) {
    const positiveKeywords = keywords.filter((kw) => kw.startsWith('+')).map((kw) => kw.slice(1));
    const negativeKeywords = keywords.filter((kw) => kw.startsWith('-')).map((kw) => kw.slice(1));
    return { positiveKeywords, negativeKeywords };
  }
  
  async function calculateCosineSimilarity(searchTerm, itemTitle) {
    const tokenizer = new natural.WordTokenizer();
    const searchTermTokens = tokenizer.tokenize(searchTerm);
    const itemTitleTokens = tokenizer.tokenize(itemTitle);
  
    const termFrequency = new natural.TfIdf();
    termFrequency.addDocument(searchTermTokens);
    termFrequency.addDocument(itemTitleTokens);
  
    const searchTermTfidf = termFrequency.listTerms(0).map((term) => term.tfidf);
    const itemTitleTfidf = termFrequency.listTerms(1).map((term) => term.tfidf);
  
    // Pad the shorter vector with zeros
    while (searchTermTfidf.length < itemTitleTfidf.length) {
      searchTermTfidf.push(0);
    }
  
    while (itemTitleTfidf.length < searchTermTfidf.length) {
      itemTitleTfidf.push(0);
    }
  
    const searchTermVector = tf.tensor1d(searchTermTfidf);
    const itemTitleVector = tf.tensor1d(itemTitleTfidf);
  
    const dotProduct = tf.sum(tf.mul(searchTermVector, itemTitleVector));
    const normA = tf.norm(searchTermVector);
    const normB = tf.norm(itemTitleVector);
    const cosineSimilarity = dotProduct.div(normA.mul(normB));
  
    return cosineSimilarity.dataSync()[0];
  }
  
  
  
  
  export function isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords) {
    //const similarity = natural.JaroWinklerDistance(searchTerm, itemTitle,{});
    const similarity = calculateCosineSimilarity(searchTerm, itemTitle);
    if (similarity <= 0.8) {
      return false;
    }
  
    const itemKeywords = tokenize(itemTitle.toLowerCase());
    return positiveKeywords.every((pkw) => itemKeywords.includes(pkw.toLowerCase())) &&
      negativeKeywords.every((nkw) => !itemKeywords.includes(nkw.toLowerCase()));
  }

  
  async function loadUSEModel() {
    return await use.load();
  }
  
  async function calculateSemanticSimilarity(useModel, searchTerm, itemTitle) {
    const embeddings = await useModel.embed([searchTerm, itemTitle]);
    const similarity = await tf.tidy(() => {
      const e1 = embeddings.slice([0, 0], [1, -1]);
      const e2 = embeddings.slice([1, 0], [1, -1]);
      const dotProduct = tf.sum(tf.mul(e1, e2));
      const normProduct = tf.norm(e1).mul(tf.norm(e2));
      return tf.div(dotProduct, normProduct);
    });
    return (await similarity.data())[0];
  }
  
  
// This function takes a list of products, a search term, keywords, and an optional minimum confidence score (default 0.8),
// and returns the best matching product based on semantic similarity and matching keywords.
export async function getBestMatch_USE(productsList, searchTerm, keywords, minConfidence = 0.4) {
  // Load the Universal Sentence Encoder (USE) model
  const useModel = await loadUSEModel();
  
  // Set the input data to the products list
  const data = productsList;
  
  // Extract positive and negative keywords from the input keywords
  const { positiveKeywords, negativeKeywords } = getPositiveAndNegativeKeywords(keywords);
  
  // Calculate similarity scores for each item in the products list
  const scoredItems = await Promise.all(
    data.map(async (item) => {
      // Get the item title in lowercase
      const itemTitle = item['title'].toLowerCase();
      
      // Calculate the semantic similarity between the search term and item title
      const similarity = await calculateSemanticSimilarity(useModel, searchTerm, itemTitle);
      
      // Determine if the item title matches the search term and keywords
      const match = isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords);
      
      // Return an object containing the item and its score, which is the product of similarity and match
      return {
        item: item,
        score: similarity * (match ? 1 : 0),
      };
    })
  );
  
  // Sort the scored items in descending order of their scores
  const sortedScoredItems = scoredItems.sort((a, b) => b.score - a.score);
  
  // Return the first item in the sorted list if its score is greater than or equal to the minimum confidence, otherwise return null
  if (sortedScoredItems.length > 0 && sortedScoredItems[0].score >= minConfidence) {
    return sortedScoredItems[0].item;
  } else {
    return null;
  }
}

 export async function getBestMatch_USE_Pjson(jsondata, searchTerm, keywords, minConfidence = 0.65) {
    const useModel = await loadUSEModel();
    const data = jsondata['products'];
    const { positiveKeywords, negativeKeywords } = getPositiveAndNegativeKeywords(keywords);
  
    const scoredItems = await Promise.all(
      data.map(async (item) => {
        const itemTitle = item['title'].toLowerCase();
        const similarity = await calculateSemanticSimilarity(useModel, searchTerm, itemTitle);
        const match = isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords);
  
        return {
          item: item,
          score: similarity * (match ? 1 : 0),
        };
      })
    );
  
    const sortedScoredItems = scoredItems.sort((a, b) => b.score - a.score);
  
    if (sortedScoredItems.length > 0 && sortedScoredItems[0].score >= minConfidence) {
      return sortedScoredItems[0].item;
    } else {
      return null;
    }
  }
  
  
  
  // export async function getBestMatch(jsondata, searchTerm, keywords) {
  //   const data = jsondata['products'];
  //   const { positiveKeywords, negativeKeywords } = getPositiveAndNegativeKeywords(keywords);
  
  //   let bestMatch = null;
  //   for (const item of data) {
  //     const itemTitle = item['title'].toLowerCase();
  //     if (isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords)) {
  //       bestMatch = item;
  //       break;
  //     }
  //   }
  
  //   return bestMatch;
  // }

  
  
  export async function getProductDetails(jsondata, product, size, keywords) {
    const searchTerm = product.toLowerCase();
    const foundProduct = await getBestMatch_USE_Pjson(jsondata, searchTerm, keywords);
  
    if (foundProduct) {
      const handle = foundProduct['handle'];
  
      const foundVariant = foundProduct["variants"].find(variant => variant.option1 === size);
  
      if (foundVariant) {
        const sizeId = foundVariant.id;
        const price = foundVariant.price;
        return { handle, price};
      } else {
        console.log("Size not found");
        throw { name: 'SizeNotFoundError', message: 'The size has not been found' };
      }
    } else {
      console.log('failed');
      throw { name: 'NoProductFoundError', message: 'The product has not been found' };
    }
  }
  