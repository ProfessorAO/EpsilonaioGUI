
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');

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
    if (await page.$(selector)) {
      console.log('popup');
      await sleep(2000);
      await page.keyboard.press('Escape');
    }
  }
  
  export function getPositiveAndNegativeKeywords(keywords) {
    const positiveKeywords = keywords.filter((kw) => kw.startsWith('+')).map((kw) => kw.slice(1));
    const negativeKeywords = keywords.filter((kw) => kw.startsWith('-')).map((kw) => kw.slice(1));
    return { positiveKeywords, negativeKeywords };
  }
  
  export function isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords) {
    const similarity = natural.JaroWinklerDistance(searchTerm, itemTitle,{});
    if (similarity <= 0.8) {
      return false;
    }else{
      return true;
    }
      
  
    const itemKeywords = tokenize(itemTitle.toLowerCase());
    return positiveKeywords.every((pkw) => itemKeywords.includes(pkw.toLowerCase())) &&
      negativeKeywords.every((nkw) => !itemKeywords.includes(nkw.toLowerCase()));
  }
  
  export async function getBestMatch(jsondata, searchTerm, keywords) {
    const data = jsondata['products'];
    const { positiveKeywords, negativeKeywords } = getPositiveAndNegativeKeywords(keywords);
  
    let bestMatch = null;
    for (const item of data) {
      const itemTitle = item['title'].toLowerCase();
      if (isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords)) {
        bestMatch = item;
        break;
      }
    }
  
    return bestMatch;
  }
  
  
  export async function getProductDetails(jsondata, product, size, keywords) {
    const searchTerm = product.toLowerCase();
    const foundProduct = await getBestMatch(jsondata, searchTerm, keywords);
  
    if (foundProduct) {
      const handle = foundProduct['handle'];
  
      const foundVariant = foundProduct["variants"].find(variant => variant.option1 === size);
  
      if (foundVariant) {
        //const sizeId = foundVariant.id;
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
  