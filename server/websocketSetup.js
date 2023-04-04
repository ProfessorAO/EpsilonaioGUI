
import puppeteer from 'puppeteer';
import { WebSocketServer } from 'ws';
import fs from 'fs';
import http from 'http';
import { type } from 'os';
import express from 'express';
import { Console } from 'console';
import trapstarBot from './Bots/TrapstarBot';
import get_releases_data from './Data/releasesData';
const wrongTypeError = TypeError("Wrong type found, expected ");


async function connection_websockets() {
    const task_wss = new WebSocketServer({ port: 679 });
    const releases_wss = new WebSocketServer({ port: 6969 });
  
    setupWebSocketServer(task_wss, 'Task Creation', async (ws) => {
      const task_data = await waitForDataJson(ws);
      const website = task_data.store;
      switch(website){
        case 'Trapstar':
          trapstarBot(task_data, ws);
          break;
        default:
          console.log('Website not supported');
      }
      
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
  
function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}

function check_dataTypes(Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone) {
    const args = [Product, Size, FirstName, LastName, CardName, CardNumber, Address, City, Postcode, Phone];
    return args.every(arg => typeof arg === 'string');
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









