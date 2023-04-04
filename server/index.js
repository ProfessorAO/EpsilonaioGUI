
import puppeteer from 'puppeteer';
import { WebSocketServer } from 'ws';
import fs from 'fs';
import http from 'http';
import { type } from 'os';
import express from 'express';
import { Console } from 'console';
const wrongTypeError = TypeError("Wrong type found, expected ");
async function connection_websockets() {
    const task_wss = new WebSocketServer({ port: 679 });
    const releases_wss = new WebSocketServer({ port: 6969 });
  
    setupWebSocketServer(task_wss, 'Task Creation', async (ws) => {
      const task_data = await waitForDataJson(ws);
      trapstartBot(task_data, ws);
    });
  
    setupWebSocketServer(releases_wss, 'Release Data Request', async (ws) => {
      const release_data = await waitForData(ws);
      get_releases_data(ws);
    });
  
    function setupWebSocketServer(wss, eventType, onConnection) {
      wss.on('connection', async (ws) => {
        console.log(`New Websocket connection - ${eventType}`);
        await onConnection(ws);
      });
  
      wss.on('close', () => {
        console.log(`Connection closed - ${eventType}`);
      });
    }
  
    async function waitForDataJson(ws) {
      return new Promise((resolve, reject) => {
        ws.on('message', function message(data) {
          console.log('data: %s', data);
          const res_data = JSON.parse(data);
          resolve(res_data);
        });
      });
    }
  
    async function waitForData(ws) {
      return new Promise((resolve, reject) => {
        ws.on('message', function message(data) {
          console.log('data: %s', data);
          resolve(data);
        });
      });
    }
  }
  

// async function connection_websockets(){
//     const obj = new Object;
//     const task_wss = new WebSocketServer({port:679 });
//     const releases_wss = new WebSocketServer({port: 6969})
//     var task_data;
//     var release_data;
//     task_wss.on('connection',async (ws)=>{
//         console.log('New Websocket connection - Task Creation');
//         task_data = await waitForData_Json(ws);
//         trapstartBot(task_data,ws);
//     })

//     task_wss.on('close',(ws)=>{
//         console.log("connection closed - Task Creation");
//     })
//     releases_wss.on('connection',async (ws)=>{
//         console.log('New Websocket connection - Release Data Request');
//         release_data = await waitForData(ws);
//         get_releases_data(ws);
        
//     })

//     releases_wss.on('close',(ws)=>{
//         console.log("connection closed - Release Data Request");
//     })
//     async function waitForData_Json(ws){
//         return new Promise((resolve, reject) => {
//             ws.on('message', function message(data){
//                 var res_data;
//                 console.log('data: %s',data);
//                 res_data =  JSON.parse(data);
//                 resolve(res_data);
//             });
//         });
//     }
//     async function waitForData(ws){
//         return new Promise((resolve, reject) => {
//             ws.on('message', function message(data){
//                 console.log('data: %s',data);
//                 resolve(data);
//             });
//         });
//     }
// }


function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}
function get_releases_data(socket){
    var docutext = fs.readFileSync("./Upcoming releases.txt").toString('utf-8');
    var text_parsed = JSON.parse(docutext);
    console.log('Data retrieved');
    socket.send(JSON.stringify(text_parsed));
    console.log('Data sent');
    
}
function check_dataTypes(Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone) {
    const args = [Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone];
    return args.every(arg => typeof arg === 'string');
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
  async function getInnerTxt(page) {
    return await page.evaluate(() => {
      return JSON.parse(document.querySelector("body").textContent);
    });
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
function trapstartBot(task_data,socket){
   var Product = task_data["product"];
   var Size = task_data["size"];
   var ID = task_data['ID'];
   var Store = task_data['store'];
   var FirstName = task_data['first_name'];
   var LastName = task_data['last_name'];
   var CardName = task_data['card_name'];
   var CardNumber = task_data['card_number'];
   var Address = task_data['address'];
   var City = task_data['city'];
   var Postcode = task_data['postcode'];
   var Phone = task_data['phone'];
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
};
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
  

// function gethandle(jsondata,product){
//     let data = jsondata["products"];
//     let found = false;
//     for (let i = 0; i<data.length; i++) {
//         if (data[i]["title"].toLowerCase().includes(product.toLowerCase())){
//             return data[i]["handle"];
//         }else{
//             found = false;
//         }
//     }
//     if (found== false){
//         console.log("failed");
//         throw {name : "NoProductFoundError", message : "The product has not been found"};
//     }
//     //console.log(json_str);
// }
// function getsizeid(jsondata,product,size){
//     let data = jsondata["products"];
//     for (let i = 0; i<data.length; i++) {
//         if (data[i]["title"].toLowerCase().includes(product.toLowerCase())){
//             let y = data[i]["variants"].length;
//             for (let x =0;x<y;x++){
//                 if (data[i]["variants"][x].option1== size){
//                     return (data[i]["variants"][x].id);
//                 }
//             }
//         }
//     }
// }
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
  

function connection_express(){
    const conn = express();
    const PORT = 3000;
    conn.listen(PORT,()=>
    console.log('Listening for connection to http://localhost:${PORT}'),);

    conn.get('',(req,res)=>{
        res.send('Hello World!');
    });


}
connection_websockets();







