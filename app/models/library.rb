class Library < ActiveRecord::Base

  include ChartHelper

  has_many :tweets

  validates :twitter_id,  :presence => true, :uniqueness => true
  validates :username,    :presence => true, :uniqueness => true

  def build_from_screename(screen_name)

    #Strip @ if it exists
    screen_name = screen_name.gsub("@", "")

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_consumer_key']
      config.consumer_secret     = ENV['twitter_consumer_secret']
      config.access_token        = ENV['twitter_oauth_token']
      config.access_token_secret = ENV['twitter_oauth_token_secret']
    end

    user = client.user(screen_name)

    if user.id
      self.username = screen_name
      self.twitter_id = user.id
      self.save!
    end

  end

  def change_in_followers_by_date(start_date = Date.new(2012,01,01), end_date = Date.today)
    change = {}
    followers_by_date(start_date, end_date).each_cons(2) do |row_a, row_b|
      change[row_b[0]] = row_b[1] - row_a[1] 
    end
    change
  end

  def followers_by_date(start_date = Date.new(2012,01,01), end_date = Date.today)
    tweets.select("MAX(followers) AS followers, date(tweet_created_at)").between_dates(start_date, end_date).group('date(tweet_created_at)').reorder('date(tweet_created_at)').map{ |row| [row.date, row.followers] }
  end

  def mentions_by_date(start_date = Date.new(2012,01,01), end_date = Date.today)
    Tweet.unscoped.by_a_mentioner.between_dates(start_date, end_date).where("mentions @> '{#{self.username}}'::text[]").group('date(tweet_created_at)').reorder('date(tweet_created_at)').count
  end

  def ratio_of_tweets_with_hashtags(start_date = Date.new(2012,01,01), end_date = Date.today)
    total = tweets.count
    with_hashtags = tweets.where("array_upper(hashtags, 1) IS NOT NULL").count
    [with_hashtags, total - with_hashtags]
  end

  def ratio_of_tweets_with_links(start_date = Date.new(2012,01,01), end_date = Date.today)
    total = tweets.count
    with_urls = tweets.where("array_upper(urls, 1) IS NOT NULL").count
    [with_urls, total - with_urls]
  end

  def ratio_of_tweets_with_mentions(start_date = Date.new(2012,01,01), end_date = Date.today)
    total = tweets.count
    with_mentions = tweets.where("array_upper(mentions, 1) IS NOT NULL").count
    [with_mentions, total - with_mentions]
  end

  def self.rank_by_followers
    rank = {}
    ids = Tweet.unscoped.select("MAX(id) AS id").by_a_library.group(:username).collect(&:id)
    Tweet.unscoped.where(:id => ids).order('followers DESC').each do |tweet|
      rank[tweet.username] = tweet.followers
    end
    rank
  end

  def self.rank_by_mentions
    rank = {}
    Library.pluck(:username).each do |library|
      rank[library] = Tweet.unscoped.by_a_mentioner.where(" mentions @> '{#{library}}'::text[] ", library).count
    end
    rank.sort_by{|k,v| v}.reverse.to_h
  end

  def self.rank_by_tweets
    Tweet.unscoped.by_a_library.group(:username).order('count_id DESC').count(:id)
  end

  def total_change_in_followers(start_date = Date.new(2012,01,01), end_date = Date.today)
    changes = followers_by_date(start_date, end_date)
    changes.last[1] - changes.first[1]
  end

  def total_mentions(start_date = Date.new(2012,01,01), end_date = Date.today)
    Tweet.unscoped.by_a_mentioner.between_dates(start_date, end_date).where("mentions @> '{#{self.username}}'::text[]").count
  end

  def total_tweets(start_date = Date.new(2012,01,01), end_date = Date.today)
    tweets.between_dates(start_date, end_date).count
  end

  def tweets_by_date(start_date = Date.new(2012,01,01), end_date = Date.today)
    tweets.between_dates(start_date, end_date).group('date(tweet_created_at)').reorder('date(tweet_created_at)').count
  end
  
end
