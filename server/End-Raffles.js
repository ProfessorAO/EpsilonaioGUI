
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
await page.keyboard.type('launches.endclothing.com', {delay: 100})
await sleep(1000);
await page.click('.gNO89b');
await sleep(5000);
await page.click('.yuRUbf');
await sleep(5000);
await page.goto('https://launches.endclothing.com/product/nike-dunk-low-lx-w-dv3054-600');
await sleep(5000);
await page.click('#app-container > div.sc-1eymrxb-0.eqfGZp > div > div > div > div.sc-z9yvqd-3.fXQKaz > div.sc-z9yvqd-2.epXxfi > button');

await page.click('#__next > div.sc-2zw5y3-3.gFBtiH > div > div.sc-2zw5y3-2.lfEYMW > div > div > div > div:nth-child(1) > div.sc-1p4gaia-0.edjMjR > button.sc-dld20s-0.efIRgB');