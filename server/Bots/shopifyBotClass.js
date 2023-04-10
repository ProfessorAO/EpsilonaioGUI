// Import any required libraries or packages
const puppeteer = require('puppeteer');
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');

class ShopifyBot {
  constructor(browserOptions = { headless: true,
    ignoreDefaultArgs: ["--enable-automation"],
    args: [
      "--start-maximized",
      "disable-gpu",
      "--disable-infobars",
      "--disable-extensions",
      "--ignore-certificate-errors",
      "--disable-notifications",
      "--enable-popup-blocking",
    ],},
     instructionFunction = () => {}) {
    this.browserOptions = browserOptions;
    this.instructionFunction = instructionFunction;
  }

  async initBrowser() {
    this.browser = await puppeteer.launch(this.browserOptions);
  }

  async newPage() {
    this.page = await this.browser.newPage();
  }

  async closeBrowser() {
    await this.browser.close();
  }

  async executeInstructions() {
    await this.instructionFunction(this.page);
  }


  async run() {
    await this.initBrowser();
    await this.newPage();
    await this.executeInstructions();
    await this.closeBrowser();
  }
}
function tokenize(str) {
  return str.match(/\b\w+\b/g);
}

async function closePopupIfExists(page, selector) {
  if (await page.$(selector)) {
    console.log('popup');
    await sleep(2000);
    await page.keyboard.press('Escape');
  }
}
function getPositiveAndNegativeKeywords(keywords) {
  const positiveKeywords = keywords.filter((kw) => kw.startsWith('+')).map((kw) => kw.slice(1));
  const negativeKeywords = keywords.filter((kw) => kw.startsWith('-')).map((kw) => kw.slice(1));
  return { positiveKeywords, negativeKeywords };
}

function isMatch(itemTitle, searchTerm, positiveKeywords, negativeKeywords) {
  const similarity = natural.JaroWinklerDistance(searchTerm, itemTitle,{});
  if (similarity <= 0.8) {
    return false;
  }

  const itemKeywords = tokenize(itemTitle.toLowerCase());
  return positiveKeywords.every((pkw) => itemKeywords.includes(pkw.toLowerCase())) &&
    negativeKeywords.every((nkw) => !itemKeywords.includes(nkw.toLowerCase()));
}

async function getBestMatch(jsondata, searchTerm, keywords) {
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


async function getProductDetails(jsondata, product, size, keywords) {
  const searchTerm = product.toLowerCase();
  const foundProduct = await getBestMatch(jsondata, searchTerm, keywords);

  if (foundProduct) {
    const handle = foundProduct['handle'];

    const foundVariant = foundProduct["variants"].find(variant => variant.option1 === size);

    if (foundVariant) {
      const sizeId = foundVariant.id;
      const price = foundVariant.price;
      return { handle, sizeId, price};
    } else {
      console.log("Size not found");
      throw { name: 'SizeNotFoundError', message: 'The size has not been found' };
    }
  } else {
    console.log('failed');
    throw { name: 'NoProductFoundError', message: 'The product has not been found' };
  }
}


// Usage example
// const instructionFunction = async (page) => {
//   await page.goto('https://example.com');
//   console.log(await page.title());
// };

// const bot = new Bot({ headless: false }, instructionFunction);
// bot.run();
