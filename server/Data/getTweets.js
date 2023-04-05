import puppeteer from 'puppeteer';
import fs from 'fs/promises'; 

async function saveTweetsToFile(tweets, filename) {
  const data = tweets.join('\n');
  await fs.writeFile(filename, data, 'utf8');
}


async function getTweets(query, tweetCount ) {
  const base_url = 'https://twitter.com/search?q=';
  const query_url = `${base_url}${query}&src=typed_query&f=live`;

  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto(query_url);

  let tweets = [];

  while (tweets.length < tweetCount) {
    console.log(tweets.length.toString());
    await page.waitForTimeout(2000); // Allow the page to load

    const tweetNodes = await page.$$eval(
      'article[data-testid="tweet"]',
      (articles) => {
        return articles.map((article) => {
          const tweetContent = article.querySelector('div[lang]');
          if (tweetContent && tweetContent.getAttribute('lang') === 'en') {
            
            return tweetContent.textContent;
          }
          return null;
        });
      }
    );

    tweets = tweets.concat(tweetNodes.filter((tweet) => tweet !== null));
    if (tweets.length >= tweetCount) {
      tweets = tweets.slice(0, tweetCount);
      break;
    }
    await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
  }

  await browser.close();
  return tweets;
}


  
  const searchQuery = 'Air Jordan 3 Lucky Green';
  getTweets(searchQuery, 1000).then((fetchedTweets) => {
    fetchedTweets.forEach((tweet) =>saveTweetsToFile(fetchedTweets, 'tweets.txt').catch((err) => {
      console.error(`Failed to save tweets to file: ${err.message}`);
    }) );
    
  });
  
