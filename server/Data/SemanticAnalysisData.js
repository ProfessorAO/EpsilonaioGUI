import { fetchAndSaveTweets } from './getTweets.js';
import { exec } from 'child_process';


export async function SemanticAnalysis(topic, hashtags, tweetCount, socket) {
  const filename = 'tweets.txt';
  await fetchAndSaveTweets(topic, hashtags, tweetCount, filename);
  await exec('python Data/sentimentAnalysis.py', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error executing the Python script: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`Python script stderr: ${stderr}`);
    }
    console.log(`Python script output: ${stdout}`);
    socket.send(stdout);
  });
}
