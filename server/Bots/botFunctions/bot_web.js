
import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
import EvasionsPlugin from'puppeteer-extra-plugin-stealth';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const natural = require('natural');

  
export async function initBrowser(){
    const browser = await puppeteer.launch({ headless: false,
      ignoreDefaultArgs: ["--enable-automation"],
      args: [
        '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-infobars',
      '--window-position=0,0',
      '--ignore-certifcate-errors',
      '--ignore-certifcate-errors-spki-list',
      '--disable-dev-shm-usage',
      '--disable-extensions',
      '--disable-features=site-per-process',
      '--disable-hang-monitor',
      '--disable-ipc-flooding-protection',
      '--disable-renderer-backgrounding',
      '--disable-breakpad',
      '--disable-notifications',
      '--disable-translate',
      '--disable-save-password-bubble',
      '--disable-background-timer-throttling',
      '--disable-backgrounding-occluded-windows',
      '--disable-renderer-backgrounding',
      '--disable-features=TranslateUI',
      '--disable-client-side-phishing-detection',
      '--disable-popup-blocking',
      '--disable-features=IsolateOrigins,site-per-process',
      '--disable-bundled-ppapi-flash',
      '--disable-web-security',
      '--allow-running-insecure-content',
      '--disable-features=Translate,InfiniteSessionRestore,SimpleCacheBackend',
      '--disable-sync',
      
      ],},);
      return browser;
  }
  export async function initBrowser_Tor(){
    const browser = await puppeteer.launch({ headless: false,
      ignoreDefaultArgs: ["--enable-automation"],
      args: [
        '--no-sandbox',
      '--disable-setuid-sandbox',
      '--disable-infobars',
      '--window-position=0,0',
      '--ignore-certifcate-errors',
      '--ignore-certifcate-errors-spki-list',
      '--disable-dev-shm-usage',
      '--disable-extensions',
      '--disable-features=site-per-process',
      '--disable-hang-monitor',
      '--disable-ipc-flooding-protection',
      '--disable-renderer-backgrounding',
      '--disable-breakpad',
      '--disable-notifications',
      '--disable-translate',
      '--disable-save-password-bubble',
      '--disable-background-timer-throttling',
      '--disable-backgrounding-occluded-windows',
      '--disable-renderer-backgrounding',
      '--disable-features=TranslateUI',
      '--disable-client-side-phishing-detection',
      '--disable-popup-blocking',
      '--disable-features=IsolateOrigins,site-per-process',
      '--disable-bundled-ppapi-flash',
      '--disable-web-security',
      '--allow-running-insecure-content',
      '--disable-features=Translate,InfiniteSessionRestore,SimpleCacheBackend',
      '--disable-sync',
      '--proxy-server=socks5://127.0.0.1:9150'
      ],},);
      return browser;
  }
  export async function newPage(browser){
     const page = await browser.newPage();
     const userAgent = ['Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
    ]
    await page.setUserAgent(userAgent[ Math.floor(Math.random() * 3)]);
    return page;
  }
