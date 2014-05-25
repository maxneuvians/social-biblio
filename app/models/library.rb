class Library < ActiveRecord::Base

  validates :twitter_id,  :presence => true, :uniqueness => true
  validates :username,    :presence => true, :uniqueness => true

  def self.rank_by_followers
    rank = {}
    pluck(:username).each do |username|
      tweet = Tweet.find_by(:username => username)
      rank[username] = tweet.followers if tweet
    end
    rank.sort_by{|k,v|v}.reverse
  end

end
