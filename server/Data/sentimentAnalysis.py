import tweepy
import asyncio
from collections import Counter
from textblob import TextBlob
from transformers import pipeline
import tweepy.errors
import re

async def sentiment_analysis_async(tweets):
    results = []
    sentiment_classifier = pipeline("sentiment-analysis")
    for tweet in tweets:
        try:
            sentiment = sentiment_classifier(tweet)[0]
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

def extract_keywords(tweets, top_n=10):
    words = []
    for tweet in tweets:
        words.extend(re.findall(r'\w+', tweet.lower()))
    word_counts = Counter(words)
    return word_counts.most_common(top_n)


def main():
    tweets = get_tweets()
    sentiment_results = sentiment_analysis(tweets)

    negative_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "NEGATIVE"]
    positive_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "POSITIVE"]
    positive_count = sum(1 for _, sentiment in sentiment_results if sentiment == "POSITIVE")
    negative_count = sum(1 for _, sentiment in sentiment_results if sentiment == "NEGATIVE")

    print(f"Positive tweets: {positive_count}")
    print(f"Negative tweets: {negative_count}")

    # Extract top keywords
    top_keywords = extract_keywords(tweets)
    print("Top keywords:")
    for word, count in top_keywords:
        print(f"{word}: {count}")


main()
