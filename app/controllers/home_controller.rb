class HomeController < ApplicationController

  def index

    @total_hashtags = 0
    @total_mentions = 0 
    @total_urls     = 0
    @total_tweets   = 0

    @hashtags       = Hash.new(0)

    @todays_tweets = Tweet.get_library_tweets_for_today

    @todays_tweets.each do |tweet|

      @total_hashtags += tweet.hashtags.length
      @total_mentions += tweet.hashtags.length
      @total_urls += tweet.hashtags.length
      @total_tweets += 1

      tweet.hashtags.each do |tag|
        @hashtags[tag] += 1
      end

    end

    @hashtags = @hashtags.sort_by{|k,v|v}

  end

end
