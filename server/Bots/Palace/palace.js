
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');
import * as botPack from '../botFunctions/bot_nav.js';
import * as webPack from '../botFunctions/bot_web.js';
import { url } from 'inspector';


export default function PalaceBot(data, socket) {
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
                         const browser = await webPack.initBrowser();
                         const page = await webPack.newPage(browser);
                         socket.send('Ready');
                         await processCheckout(socket,data,page);
                         await page.screenshot({path: 'C:/Users/david/EpsilonaioGUI/server/success_pics/'+ID+' '+dateString+ '.png'});
                         console.log('Screenshotted');
                         await botPack.sleep(5000);
                         console.log("Done");
                         socket.send('Completed');
                         browser.close();

                        
                         
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
  
  
function check_dataTypes(Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone) {
    const args = [Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone];
    return args.every(arg => typeof arg === 'string');
  }

  async function processCheckout(socket,data,page){
    await page.setDefaultNavigationTimeout(80000); 
    let query = createQuery(data.product);
    await page.goto('https://shop.palaceskateboards.com/search?q='+ query);
    let url = await getPageURL(data,socket,page);
    await page.goto(url,{ waitUntil: 'networkidle2' });
    await botPack.sleep(2000);
    await selectSize(data,socket,page);
    await botPack.sleep(1000);
    const priceText = await page.$eval('h3.product-price span.prod-price', element => element.textContent);
    socket.send(priceText.replace(/£/g, ''));  
    await page.waitForSelector('#head-right > a');
    await page.goto('https://shop.palaceskateboards.com/cart');
    socket.send('Added To Cart')
    await page.click('.checkbox-control');
    const str = '"Checkout"';
    await page.click("input[value="+str+"]");
    await page.waitForNavigation();
    socket.send('Checking out');
    await fillCheckoutForm(page,data);
    await page.click('#continue_button');
  }


  async function fillCheckoutForm(page, data) {
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
    await page.focus("#checkout_email");
    await botPack.sleep(2000);
    //await page.keyboard.type("davidodunlade@hotmail.co.uk");
    await page.keyboard.type("davidodunlade@hotmail.co.uk",{delay:100});
  }

  function createQuery(product){
    return product.toLowerCase().split(' ').join('+');
  }
  async function selectSize(data,socket,page){
    //await page.click('#product-select');
    const size = getCorrectSizeFormat(data.size);
    try {
      await page.evaluate((size) => {
        const selectElement = document.querySelector("#product-select");
        const options = selectElement.options;
    
        for (let i = 0; i < options.length; i++) {
          if (options[i].textContent === size) {
            selectElement.selectedIndex = i;
            break;
          }
        }
      }, size);
      const str = '"Add to Cart"';
      await page.click("input[value="+str+"]");
    } catch (error) {
      console.log("Failed");
      socket.send("Failed");
      console.log(error.message);
      
    }
    
      
  }

  function getCorrectSizeFormat(size){
    var newSize;
    switch(size){
      case 'XS':
      newSize = 'X-Small';
      break;
      case 'S':
      newSize = 'Small';
      break;
      case 'M':
      newSize = 'Medium';
      break;
      case 'L':
      newSize = 'Large';
      break;
      case 'XL':
      newSize = 'X-Large';
      break;
    }
    return newSize;
  }
  async function getPageURL(data, socket, page) {
    try {
      const { positiveKeywords, negativeKeywords } = botPack.getPositiveAndNegativeKeywords(data.keywords);
  
      const productElements = await page.evaluate(() => {
        const searchresults = document.querySelector("#searchresults");
        const searchList = searchresults.querySelectorAll("li");
        const products = [];
        for (const item of searchList) {
          const productElement = item.querySelector("h3 a");
          products.push({ title: productElement.innerText, url: productElement.href });
        }
        return products;
      });
  
      for (const product of productElements) {
        if (botPack.isMatch(product.title, data.product, positiveKeywords, negativeKeywords)) {
          return product.url;
        }
      }
    } catch (error) {
      console.log("Failed");
      socket.send("Failed");
      console.log(error.message);
    }
  }
  

  
  
  
  