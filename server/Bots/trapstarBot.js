// trapstarBot.js
export default function trapstarBot(data, socket) {
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
                         processCheckout(page,FirstName, LastName, Address, City, Phone, Postcode,socket);
                         await page.screenshot({path: 'C:/Users/david/EpsilonaioGUI/server/success_pics/'+ID+' '+dateString+ '.png'});
                         await sleep(5000);
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

function check_dataTypes(Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone) {
    const args = [Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone];
    return args.every(arg => typeof arg === 'string');
  }
  function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}
  async function processCheckout(page,FirstName, LastName, Address, City, Phone, Postcode,socket){
    const browser = await launchBrowser();
    const page = await browser.newPage();
    await page.setDefaultNavigationTimeout(80000); 
    navigateToCheckout(page,socket);
    await sleep(2000);
    await fillCheckoutForm(page, FirstName, LastName, Address, City, Phone, Postcode);
    await sleep(5000);
    console.log("Checking out");
    socket.send('Checking out');
    await page.waitForSelector("#continue_button");
    await page.click("#continue_button");
    console.log("completed");
    socket.send('Completed');
    await sleep(2000);
  }
  async function navigateToCheckout(page,socket){
    await page.goto('https://uk.trapstarlondon.com/products/'+handle +'?variant='+size_id );
   //await sleep(2000);
    await page.waitForSelector('#AddToCart-product-template');
    await page.click('#AddToCart-product-template');
    console.log("Added to cart");
    socket.send('Added To Cart');
    await sleep(3000);
    await page.goto('https://uk.trapstarlondon.com/cart');
    //await Websocket.send("Checking out");
    await page.waitForSelector('input[value="Check out"]');
    await page.click('input[value="Check out"]');
    await sleep(2000);
    await page.waitForSelector('#checkout_shipping_address_first_name');
    await page.select("#checkout_shipping_address_country","United Kingdom");
  }

  async function fillCheckoutForm(page, FirstName, LastName, Address, City, Phone, Postcode) {
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

  
function gethandle(jsondata, product) {
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
  function getsizeid(jsondata, product, size) {
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