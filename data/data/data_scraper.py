# pip install snscrape

import snscrape.modules.twitter as sntwitter
import pandas as pd

query = "(from:muftimenk) until:2022-07-07 since:2011-02-05"
tweets = []
# max possible
limit = 5000000000


for tweet in sntwitter.TwitterSearchScraper(query).get_items():

    # print(vars(tweet))
    # break
    if len(tweets) == limit:
        break
    else:
        tweets.append([tweet.date,
                       tweet.username,
                       tweet.content,
                       tweet.likeCount,
                       tweet.media,
                       tweet.inReplyToUser,
                       tweet.mentionedUsers,
                       tweet.hashtags,
                       tweet.lang,
                       tweet.outlinks,
                       tweet.renderedContent,
                       tweet.replyCount,
                       tweet.retweetCount,
                       tweet.url,
                       tweet.quotedTweet])

df = pd.DataFrame(tweets, columns=['Date',
                                   'User',
                                   'Tweet',
                                   'Like Count',
                                   'Media',
                                   'In Reply To User',
                                   'Mentioned Users',
                                   'Hashtags',
                                   'Language',
                                   'Outlinks',
                                   'Rendered Content',
                                   'Reply Count',
                                   'Retweet Count',
                                   'URL',
                                   'Quoted Tweet'
                                   ])

# print(df)


df.to_csv('dataset_raw.csv')
