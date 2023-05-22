
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');
import * as botPack from '../botFunctions/bot_nav.js';
import * as webPack from '../botFunctions/bot_web.js';
import path from 'path';


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
    var card_number = data['card_number'];
    var card_name = data['card_name'];
    data['exp'] =  String(1212);
    data['security_code'] = String(1234);



  
    
    var today = new Date();
    var dateString = today.toLocaleString().replace(/[/,:]/g, ' ');
 
     if (check_dataTypes(Product,Size,FirstName,LastName,CardName,CardNumber,Address,City,Postcode,Phone)) {
         (async () => {
                     try {
                      let browser;
                      if(data.tor_used == true){browser = await webPack.initBrowser_Tor();
                      }else{browser = await webPack.initBrowser();}
                         const page = await webPack.newPage(browser);
                         socket.send('Ready');
                         await processCheckout(socket,data,page);
                         await page.screenshot({path: 'C:/Users/david/EpsilonaioGUI/server/success_pics/'+ID+' '+dateString+ '.png'});
                         await botPack.sleep(5000);
                         socket.send('Completed');
                         browser.close(); 
                     } catch (error) {
                         console.error("Failed");
                         socket.send('Failed');
                         console.log(error.message); 
                         browser.close();
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
   
    //await page.goto(`file://${path.resolve('C:/Users/david/uk.trapstarlondon.com/index.html')}`);
    await page.goto("https://uk.trapstarlondon.com/products.json?100000000");
    var innerText = await botPack.getInnerTxt(page);
    const result = await botPack.getProductDetails (innerText,data.product,data.size,data.keywords);
    var handle = result.handle;
    var size_id = result.sizeId;
    var price = result.price;
    socket.send(price);

    await page.goto('https://uk.trapstarlondon.com/products/'+handle +'?variant='+size_id );
    //await page.goto(`file://${path.resolve('C:/Users/david/uk.trapstarlondon.com/products/chain-script-hoodie-black-green.html?variant=39995971993675')}`);
   //await sleep(2000);
    await page.waitForSelector('#AddToCart-product-template');
    await page.click('#AddToCart-product-template');
    await botPack.sleep(5000);
    socket.send('Added To Cart');
    console.log('In Cart');
    await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    //await page.waitForNavigation();
    //await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await page.waitForSelector('input[value="Check out"]');
    //await botPack.sleep(5000);
    await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await page.click('input[value="Check out"]');
    await page.waitForNavigation();
    await botPack.sleep(1000);
    await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await fillCheckoutForm(page, data);
    await botPack.sleep(5000);
    console.log("Checking out");
    await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    socket.send('Checking out');
    await botPack.sleep(5000);
    await botPack.closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await page.waitForSelector("#continue_button");
    await page.click("#continue_button");
    await page.waitForSelector("#continue_button");
    await page.click("#continue_button");
    await botPack.sleep(5000);
    await fillCardForm(page,data);
    console.log("completed");
    await botPack.sleep(2000);
 
    
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
    await botPack.sleep(2000);
    await page.keyboard.type("davidodunlade@hotmail.co.uk",{delay: 10});
  }

  async function fillCardForm(page, data) {
    await botPack.sleep(3000);
  
    // Switch to the iframe for the card number
    var cardNumberFrame = await page.frames().find(f => f.name().includes('card-fields-number'));
    if (!cardNumberFrame) {
        throw new Error("Card number frame not found");
    }
    await botPack.sleep(2000);
    await cardNumberFrame.type('input[name="number"]', data.card_number, {delay: 10});
  
    // Switch to the iframe for the card name
    let cardNameFrame = await page.frames().find(f => f.name().includes('card-fields-name'));
    if (!cardNameFrame) {
        throw new Error("Card name frame not found");
    }
    await botPack.sleep(2000);
    await cardNameFrame.type('input[name="name"]', data.card_name, {delay: 10});
  
    // Switch to the iframe for the expiry date
    let cardExpiryFrame = await page.frames().find(f => f.name().includes('card-fields-expiry'));
    if (!cardExpiryFrame) {
        throw new Error("Card expiry frame not found");
    }
    await botPack.sleep(2000);
    await cardExpiryFrame.type('input[name="expiry"]', data.exp, {delay: 10});
  
    // Switch to the iframe for the security code
    let cardSecurityFrame = await page.frames().find(f => f.name().includes('card-fields-verification_value'));
    if (!cardSecurityFrame) {
        throw new Error("Card security frame not found");
    }
    await botPack.sleep(2000);
    await cardSecurityFrame.type('input[name="verification_value"]', data.security_code, {delay: 10});
  }
  

  

  
  
  
  