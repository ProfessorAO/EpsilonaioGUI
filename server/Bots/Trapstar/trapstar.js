import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { Console } from 'console';
import { sign } from 'crypto';
import { get } from 'http';
export default function trapstarBot(data, socket) {
    puppeteer.use(StealthPlugin());
    puppeteer.use(EvasionsPlugin());  
    var Product = data["product"];
    var Size = data["size"];
    var ID = data['ID'];
    var Store = data['store'];
    var FirstName = data['first_name'];
    var LastName = data['last_name'];
    var CardName = data['card_name'];
    var CardNumber = data['card_number'];
    var Address = data['address'];
    var City = data['city'];
    var Postcode = data['postcode'];
    var Phone = data['phone'];

    
    var today = new Date();
    var dateString = today.toLocaleString().replace(/[/,:]/g, ' ');
 
     if (check_dataTypes(Product,Size,FirstName,LastName,CardName,CardNumber,Address,City,Postcode,Phone)) {
         (async () => {
                     try {
                        const browser = await launchBrowser();
                        const page = await browser.newPage();
                        const userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36';
                        await page.setUserAgent(userAgent);

                         await processCheckout(FirstName, LastName, Address, City, Phone, Postcode,socket,data,page);
                         await page.screenshot({path: 'C:/Users/david/EpsilonaioGUI/server/success_pics/'+ID+' '+dateString+ '.png'});
                         await sleep(5000);
                        // var innerText = await getInnerTxt(page);
                         var price = await getprice(innerText,Product);
                         socket.send(price.toLocaleString);
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
  async function processCheckout(FirstName, LastName, Address, City, Phone, Postcode,socket,data,page){
    
    
    await page.setDefaultNavigationTimeout(80000); 
    await page.goto('https://uk.trapstarlondon.com/products.json?limit=1000');
    var innerText = await getInnerTxt(page);
    var handle = await gethandle(innerText,data.product)
    var size_id = await getsizeid(innerText,data.product,data.size);
    await page.goto('https://uk.trapstarlondon.com/products/'+handle +'?variant='+size_id );
   //await sleep(2000);
    await page.waitForSelector('#AddToCart-product-template');
    await page.click('#AddToCart-product-template');
    await sleep(5000);
    console.log("Added to cart");
    socket.send('Added To Cart');
    await sleep(5000);
    //await page.goto('https://uk.trapstarlondon.com/cart');
    //await Websocket.send("Checking out");
    console.log('In Cart');
    //await sleep(5000);
    await closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');

    await page.waitForSelector('input[value="Check out"]');
    await page.click('input[value="Check out"]');
    await sleep(2000);
    await closePopupIfExists(page, '#omnisend-form-5f4906684c7fa469cfd02c58-close-icon');
    await fillCheckoutForm(page, FirstName, LastName, Address, City, Phone, Postcode);
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
  

  async function fillCheckoutForm(page, FirstName, LastName, Address, City, Phone, Postcode) {
    await page.waitForSelector('#checkout_shipping_address_first_name');
    await page.select("#checkout_shipping_address_country","United Kingdom");
    await page.evaluate(
      (FirstName, LastName, Address, City, Phone, Postcode) => {
        const first_name = document.querySelector("#checkout_shipping_address_first_name");
        const last_name = document.querySelector("#checkout_shipping_address_last_name");
        const address = document.querySelector("#checkout_shipping_address_address1");
        const city = document.querySelector("#checkout_shipping_address_city");
        const postcode = document.querySelector("#checkout_shipping_address_zip");
        const p_number = document.querySelector("#checkout_shipping_address_phone");
  
        first_name.value = FirstName;
        last_name.value = LastName;
        address.value = Address;
        city.value = City;
        p_number.value = Phone;
        postcode.value = Postcode;
      },
      FirstName,
      LastName,
      Address,
      City,
      Phone,
      Postcode
    );
    await page.focus("#checkout_email_or_phone");
    await sleep(2000);
    await page.keyboard.type("davidodunlade@hotmail.co.uk");
  }
  async function launchBrowser() {
    return await puppeteer.launch({
      headless: false,
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

async function gethandle(jsondata, product) {
    const data = jsondata["products"];
    const searchTerm = product.toLowerCase();
  
    const foundProduct = data.find(item => item["title"].toLowerCase().includes(searchTerm));
  
    if (foundProduct) {
      return foundProduct["handle"];
    } else {
      console.log("failed");
      throw { name: "NoProductFoundError", message: "The product has not been found" };
    }
  }
  async function getprice(jsondata, product) {
    const data = jsondata["products"];
    const searchTerm = product.toLowerCase();
  
    const foundProduct = data.find(item => item["title"].toLowerCase().includes(searchTerm));
  
    if (foundProduct) {
      return foundProduct["price"];
    } else {
      console.log("failed");
      throw { name: "NoProductFoundError", message: "The product has not been found" };
    }
  }
  
  async function getsizeid(jsondata, product, size) {
    const data = jsondata["products"];
    const searchTerm = product.toLowerCase();
  
    const foundProduct = data.find(item => item["title"].toLowerCase().includes(searchTerm));
  
    if (foundProduct) {
      const foundVariant = foundProduct["variants"].find(variant => variant.option1 === size);
  
      if (foundVariant) {
        return foundVariant.id;
      } else {
        console.log("Size not found");
      }
    } else {
      console.log("Product not found");
    }
  }