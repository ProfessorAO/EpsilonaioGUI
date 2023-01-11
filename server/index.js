
import puppeteer from 'puppeteer';
import { WebSocketServer } from 'ws';
import http from 'http';
import { type } from 'os';
import express from 'express';
import { Console } from 'console';
const wrongTypeError = TypeError("Wrong type found, expected ");

async function connection_websockets(){
    const obj = new Object;
    const wss = new WebSocketServer({ port:679 });
    var task_data ;
    wss.on('connection',async (ws)=>{
        console.log('New Websocket connection');
        task_data = await waitForData(ws);
        openTrapstar(task_data,ws);
    })
    wss.on('error',(ws)=>{
        ws.send('Connection failed');
    })
    wss.on('close',(ws)=>{
        console.log("connection closed");
    })
    async function waitForData(ws){
        return new Promise((resolve, reject) => {
            ws.on('message', function message(data){
                console.log('data: %s',data);
                task_data =  JSON.parse(data);
                resolve(task_data);
            });
        });
    }
}


function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}

function openTrapstar(task_data,socket){
   var Product = task_data["product"];
   var Size = task_data["size"];

    if (typeof Product === 'string' & typeof Size === 'string') {
        (async () => {
                    try {
                        const browser = await puppeteer.launch({headless: true,args: ['--start-maximized', 'disable-gpu', '--disable-infobars', '--disable-extensions', '--ignore-certificate-errors'],});
                        const page = await browser.newPage();
                        await page.goto('https://uk.trapstarlondon.com/products.json?limit=1000');
                        await page.content(); 
                        var innertxt = await page.evaluate(()=>{
                            return JSON.parse(document.querySelector("body").textContent);
                        });
                        let handle = gethandle(innertxt,Product);
                        let size_id = getsizeid(innertxt,Product,Size);
    
                        await page.goto('https://uk.trapstarlondon.com/products/'+handle +'?variant='+size_id );
                        await page.waitForSelector('#AddToCart-product-template');
                        await page.click('#AddToCart-product-template');
                        console.log("Added to cart");
                        socket.send('Adding To Cart');
                        await sleep(1000);
                        await page.goto('https://uk.trapstarlondon.com/cart');
                        //await Websocket.send("Checking out");
                        await page.waitForSelector('input[value="Check out"]');
                        await page.click('input[value="Check out"]');
                        await sleep(2000);
                        await page.waitForSelector('#checkout_shipping_address_first_name');
                        //region
                        await page.select("#checkout_shipping_address_country","United Kingdom");
                        await page.evaluate(() =>{
                            const first_name = document.querySelector('#checkout_shipping_address_first_name');
                            const last_name = document.querySelector("#checkout_shipping_address_last_name");
                            const address = document.querySelector("#checkout_shipping_address_address1");
                            const city = document.querySelector("#checkout_shipping_address_city");
                            const postcode = document.querySelector('#checkout_shipping_address_zip');
                            const p_number = document.querySelector("#checkout_shipping_address_phone");
                            const email = document.querySelector("#checkout_email");
    
                            email.value ="davidodunlade@hotmail.co.uk"
                            first_name.value ="david";
                            last_name.value = "ade-odunlade";
                            address.value = "42 Oakwood Avenue";
                            city.value = "London";
                            p_number.value = "07984667243";
                            postcode.value = "BR3 6PJ";
    
                        });
                        await sleep(5000);
                        console.log("Checking out");
                        socket.send('Checking out');
                        await page.click("#continue_button");
                        await page.waitForSelector("#continue_button");
                        await page.click("#continue_button");
                        console.log("completed");
                        socket.send('Completed');
                        await page.screenshot({path: 'C:/Users/david/OneDrive/Documents/GitHub/EpsilonaioGUI/server/success_pics/test.png'});
                        await sleep(5000);
                        await browser.close();
                        
                    } catch (error) {
                        console.error("Failed");
                        socket.send('Failed');
                        console.log(error.details);
                        
                    }
                   
        })();
    }else{
        console.error("Failed");
    }
};

function gethandle(jsondata,product){
    let data = jsondata["products"];
    let found = false;
    for (let i = 0; i<data.length; i++) {
        if (data[i]["title"].toLowerCase().includes(product.toLowerCase())){
            return data[i]["handle"];
        }else{
            found = false;
        }
    }
    if (found== false){
        console.log("failed");
        throw {name : "NoProductFoundError", message : "The product has not been found"};
    }
    //console.log(json_str);
}
function getsizeid(jsondata,product,size){
    let data = jsondata["products"];
    for (let i = 0; i<data.length; i++) {
        if (data[i]["title"].toLowerCase().includes(product.toLowerCase())){
            let y = data[i]["variants"].length;
            for (let x =0;x<y;x++){
                if (data[i]["variants"][x].option1== size){
                    return (data[i]["variants"][x].id);
                }
            }
        }
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







