class Library < ActiveRecord::Base

  validates :twitter_id,  :presence => true, :uniqueness => true
  validates :username,    :presence => true, :uniqueness => true

  def self.rank_by_followers

    rank = {}

    ids = Tweet.unscoped.select("MAX(id) AS id").where("username in (?)", self.pluck(:username)).group(:username).collect(&:id)
    Tweet.unscoped.where(:id => ids).order('followers DESC').each do |tweet|
      rank[tweet.username] = tweet.followers
    end

    rank

  end

end
