import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');



export default function trapstarBot(data, socket) {
    puppeteer.use(StealthPlugin());
    puppeteer.use(EvasionsPlugin());  
    var Product = data["product"];
    var Size = data["size"];
    var ID = data['ID'];
    var FirstName = data['first_name'];
    var LastName = data['last_name'];
    var CardName = data['card_name'];
    var CardNumber = data['card_number'];
    var Address = data['address'];
    var City = data['city'];
    var Postcode = data['postcode'];
    var Phone = data['phone'];
    var keywords = data['keywords'];

  
    
    var today = new Date();
    var dateString = today.toLocaleString().replace(/[/,:]/g, ' ');
 
     if (check_dataTypes(Product,Size,FirstName,LastName,CardName,CardNumber,Address,City,Postcode,Phone)) {
         (async () => {
                     try {
                        socket.send('Ready');
                        const browser = await launchBrowser();
                        const page = await browser.newPage();
                        const userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36';
                        await page.setUserAgent(userAgent);

                         await processCheckout(socket,data,page);
                         await page.screenshot({path: 'C:/Users/david/EpsilonaioGUI/server/success_pics/'+ID+' '+dateString+ '.png'});
                         await sleep(5000);
                        // var innerText = await getInnerTxt(page);
                         //var price = await getprice(innerText,Product);
                         
                         await browser.close();
                         
                     } catch (error) {
                         console.error("Failed");
                         socket.send('Failed');
                         console.log(error.message); 
                     }    
         })();
     }else{
         console.error("Failed");
     }
  }
  
  async function getInnerTxt(page) {
    return await page.evaluate(() => {
      return JSON.parse(document.querySelector("body").textContent);
    });
  }
  function mapToObject(map) {
    const obj = {};
    for (let [key, value] of map) {
      obj[key] = value;
    }
    return obj;
  }
  

function check_dataTypes(Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone) {
    const args = [Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone];
    return args.every(arg => typeof arg === 'string');
  }
  function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}
  async function processCheckout(socket,data,page,price){
    
    
    await page.setDefaultNavigationTimeout(80000); 
    await page.goto('https://uk.trapstarlondon.com/products.json?limit=1000');
    var innerText = await getInnerTxt(page);
    const result = await getProductDetails (innerText,data.product,data.size,data.keywords);
    var handle = result.handle;
    var size_id = result.sizeId;
    var price = result.price;
    socket.send(price);

    await page.goto('https://uk.trapstarlondon.com/products/'+handle +'?variant='+size_id );
   //await sleep(2000);
    await page.waitForSelector('#AddToCart-product-template');
    await page.click('#AddToCart-product-template');
    await sleep(5000);
    console.log("Added to cart");
    socket.send('Added To Cart');
    await sleep(5000);
    console.log('In Cart');
    //await sleep(5000);
    await closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');

    await page.waitForSelector('input[value="Check out"]');
    await page.click('input[value="Check out"]');
    await page.waitForNavigation();
    await sleep(1000);
    await closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await fillCheckoutForm(page, data);
    await sleep(5000);
    console.log("Checking out");
    socket.send('Checking out');
    await sleep(5000);
    await closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await page.waitForSelector("#continue_button");
    await page.click("#continue_button");
    console.log("completed");
    socket.send('Completed');
    await sleep(2000);
 
    
  }
  async function closePopupIfExists(page, selector) {
    if (await page.$(selector)) {
      console.log('popup');
      await sleep(2000);
      await page.keyboard.press('Escape');
    }
  }
  

  async function fillCheckoutForm(page, data) {
    await page.waitForSelector('#checkout_shipping_address_first_name');
    await page.select("#checkout_shipping_address_country","United Kingdom");
    await page.evaluate(
      (data) => {
        const first_name = document.querySelector("#checkout_shipping_address_first_name");
        const last_name = document.querySelector("#checkout_shipping_address_last_name");
        const address = document.querySelector("#checkout_shipping_address_address1");
        const city = document.querySelector("#checkout_shipping_address_city");
        const postcode = document.querySelector("#checkout_shipping_address_zip");
        const p_number = document.querySelector("#checkout_shipping_address_phone");
  
        first_name.value = data.first_name;
        last_name.value = data.last_name;
        address.value = data.address;
        city.value = data.city;
        p_number.value = data.phone;
        postcode.value = data.postcode;
      },
      data
    );
    await page.focus("#checkout_email_or_phone");
    await sleep(2000);
    await page.keyboard.type("davidodunlade@hotmail.co.uk");
  }
  async function launchBrowser() {
    return await puppeteer.launch({
      headless: true,
      ignoreDefaultArgs: ["--enable-automation"],
      args: [
        "--start-maximized",
        "disable-gpu",
        "--disable-infobars",
        "--disable-extensions",
        "--ignore-certificate-errors",
        "--disable-notifications",
        "--enable-popup-blocking",
      ],
    });
  }

 
  function tokenize(str) {
    return str.match(/\b\w+\b/g);
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
  