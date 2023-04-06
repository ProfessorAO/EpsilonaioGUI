# consumer_key = "7ecCYc3Pe42NupwRCar96kYX0"
# consumer_secret = "VM1nTSeEawDzfOOcJiFRxsEYHM2G7BXm7WAAA1X9cjlo3n0PPA"
# access_token = "1572650676873748481-XY5P9DX2DqSr2WLFdszLFCnCUauRJH"
# access_token_secret = "3k7OTRTi8nNXSzeMTQeqGBl7GPx34N25uborBFeugRrLx"

# # Authenticate and create the Tweepy API object
# auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
# auth.set_access_token(access_token, access_token_secret)
# api = tweepy.API(auth, wait_on_rate_limit=True)

# async def get_tweets_async(topic, count=10):
#     loop = asyncio.get_event_loop()
#     tweets = []
#     try:
#         for tweet in tweepy.Cursor(api.search_tweets, q=topic, lang="en", tweet_mode="extended").items(count):
#             tweets.append(tweet.full_text)
#             await asyncio.sleep(0)
#     except tweepy.TweepError as e:
#         print(f"Error: {e}")
#     return tweets

# def get_tweets(topic, count=1000):
#     loop = asyncio.get_event_loop()
#     return loop.run_until_complete(get_tweets_async(topic, count))




import tweepy
import asyncio
from textblob import TextBlob
from transformers import pipeline
import tweepy.errors


def preprocess_tweet(tweet):
    tweet = tweet.replace('+', ' positive ')
    tweet = tweet.replace('-', ' negative ')
    return tweet

async def sentiment_analysis_async(tweets):
    results = []
    sentiment_classifier = pipeline("sentiment-analysis")
    for tweet in tweets:
        preprocessed_tweet = preprocess_tweet(tweet)
        try:
            sentiment = sentiment_classifier(preprocessed_tweet)[0]
            sentiment_type = sentiment["label"]
            results.append((tweet, sentiment_type))
            await asyncio.sleep(0)
        except Exception as e:
            print(f"Error: {e}")
    return results

def sentiment_analysis(tweets):
    loop = asyncio.get_event_loop()
    return loop.run_until_complete(sentiment_analysis_async(tweets))

def get_tweets():
    filename = 'tweets.txt'
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            tweets = f.read().splitlines()
            return tweets
    except FileNotFoundError:
        print(f"Error: {filename} not found.")

def main():
    tweets = get_tweets()
    preprocessed_tweets = [preprocess_tweet(tweet) for tweet in tweets]
    sentiment_results = sentiment_analysis(preprocessed_tweets)

    negative_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "NEGATIVE"]
    positive_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "POSITIVE"]
    positive_count = sum(1 for _, sentiment in sentiment_results if sentiment == "POSITIVE")
    negative_count = sum(1 for _, sentiment in sentiment_results if sentiment == "NEGATIVE")

    print(f"Positive tweets: {positive_count}")
    print(f"Negative tweets: {negative_count}")
    for tweet in negative_tweets:
        print(tweet)

main()
