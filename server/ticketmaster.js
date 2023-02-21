
import puppeteer from 'puppeteer';
import { WebSocketServer } from 'ws';
import http from 'http';
import { type } from 'os';
import express from 'express';
import { Console } from 'console';
const wrongTypeError = TypeError("Wrong type found, expected ");
function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
}

const browser = await puppeteer.launch({
    headless: false,
    executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe',
    userDataDir : 'C:\\Users\\david\\AppData\\Local\\Google\\Chrome\\User Data\\Profile 1',
    ignoreDefaultArgs: ["--enable-automation"],
    args: ['disable-gpu', '--disable-infobars', '--ignore-certificate-errors','--disable-notifications','--enable-popup-blocking','--disable-features=ImprovedCookieControls','--no-sandbox'],});
const page = await browser.newPage();
await page.setDefaultNavigationTimeout(80000); 

await page.goto('https://www.google.com');
await sleep(5000);
//await page.click('#L2AGLb');
await page.focus(".gLFyf");
await page.keyboard.type('ticket master', {delay: 100})
await sleep(1000);
await page.click('.gNO89b');
await sleep(5000);
await page.click('#rso > div:nth-child(1) > div > div > div > div > div > div > div.yuRUbf > a');











let json = async () => {
  console.log('Scraping');
  const browser = await puppeteer.launch({headless: false,ignoreDefaultArgs: ["--enable-automation"],args: ['--start-maximized', 'disable-gpu', '--disable-infobars', '--disable-extensions', '--ignore-certificate-errors','--disable-notifications','--enable-popup-blocking'],});
  const page = await browser.newPage();
  await page.goto('https://jsoneditoronline.org/');
  await sleep(3000);
  await page.click('.fc-button-label');
  await sleep(2000);
  await page.click("button[class='menu-button']");
  await sleep(5000);
  await page.evaluate((docutext) =>{
      const input = document.querySelector('.cm-activeLine cm-line');
},docutext);
}
json(docutext);