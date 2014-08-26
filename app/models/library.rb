class Library < ActiveRecord::Base

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

end
