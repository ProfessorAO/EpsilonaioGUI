import tweepy
import asyncio
from collections import Counter
import re
import json
import spacy
import contractions
from transformers import pipeline, AutoTokenizer, AutoModelForSequenceClassification

nlp = spacy.load("en_core_web_sm")

def expand_contractions(text):
    return contractions.fix(text)

def preprocess_text(text):
    text = expand_contractions(text)
    text = re.sub(r'http\S+', '', text)
    text = re.sub(r'@\w+', '', text)
    text = re.sub(r'[^A-Za-z\s]', '', text)
    return text

async def sentiment_analysis_async(tweets):
    results = []
    model_name = "distilbert-base-uncased-finetuned-sst-2-english"
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForSequenceClassification.from_pretrained(model_name)
    sentiment_classifier = pipeline("sentiment-analysis", model=model, tokenizer=tokenizer)
    
    for tweet in tweets:
        try:
            cleaned_tweet = preprocess_text(tweet)
            sentiment = sentiment_classifier(cleaned_tweet)[0]
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

def extract_keywords(tweets, top_n=15):
    stop_words = nlp.Defaults.stop_words

    words = []
    for tweet in tweets:
        cleaned_tweet = preprocess_text(tweet)
        words.extend(re.findall(r'\w+', cleaned_tweet.lower()))

    # Filter out stop words and single-letter words
    filtered_words = [word for word in words if word not in stop_words and len(word) > 1]

    word_counts = Counter(filtered_words)
    return word_counts.most_common(top_n)

def main():
    tweets = get_tweets()
    sentiment_results = sentiment_analysis(tweets)

    negative_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "NEGATIVE"]
    positive_tweets = [tweet for tweet, sentiment in sentiment_results if sentiment == "POSITIVE"]
    positive_count = sum(1 for _, sentiment in sentiment_results if sentiment == "POSITIVE")
    negative_count = sum(1 for _, sentiment in sentiment_results if sentiment == "NEGATIVE")

    # Extract top keywords
    top_keywords = extract_keywords(tweets)

    # Create a dictionary containing the required data
    data = {
        "positive_tweets": positive_count,
        "negative_tweets": negative_count,
        "top_keywords": {word: count for word, count in top_keywords}
    }
    print(json.dumps(data))

main()
