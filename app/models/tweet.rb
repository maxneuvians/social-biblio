class Tweet < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  include ChartHelper

  belongs_to :library

  default_scope -> { order(:tweet_created_at => :desc) }

  scope :by_a_library, -> { where("library_id != ?", 0 ) }
  scope :by_a_mentioner, -> { where("library_id = 0") }
  scope :between_dates, -> (start_date, end_date) { where("tweet_created_at >= ? and tweet_created_at <= ?", start_date.beginning_of_day, end_date.end_of_day)}

  validates :raw,               :presence => true
  validates :tweet_id,          :presence => true
  validates :content,           :presence => true
  validates :username,          :presence => true
  validates :followers,         :presence => true
  validates :tweet_created_at,  :presence => true

  def as_indexed_json(options={})
    as_json(
      only: [:id, :content, :username, :tweet_created_at]
    )
  end

  def build_from_json(json)

    status = JSON.parse json 

    self.raw = json
    self.tweet_id = status["id_str"]
    self.content = status["text"]
    self.username = status["user"]["screen_name"]
    self.followers = status["user"]["followers_count"].to_i

    hashtags_will_change!
    status['entities']['hashtags'].each do |hashtag|    
      self.hashtags.push(hashtag['text'])
    end

    urls_will_change!
    status['entities']['urls'].each do |url|
      self.urls.push(url['expanded_url'])
    end

    mentions_will_change!
    status['entities']['user_mentions'].each do |mention|  
      self.mentions.push(mention['screen_name'])
    end

    if status.has_key? 'in_reply_to_screen_name'
      self.in_reply_to = status["in_reply_to_screen_name"]
    end

    self.tweet_created_at = Time.zone.parse(status["created_at"])

    l = Library.where(:username => self.username).first

    if l 
      self.library = l 
    end

    self.save!

  end

  def get_raw 
    JSON.parse self.raw
  end

  def self.get_by_date(date)
    self.where("tweet_created_at >= ? and tweet_created_at <= ?", date.beginning_of_day, date.end_of_day)
  end

  def self.today
    self.where("tweet_created_at >= ?", Date.today.beginning_of_day)
  end

  def self.get_library_tweets_for_today
    by_a_library.today
  end

  def self.get_library_tweets_for_today_by_hour
    self.get_library_tweets_for_today.group('EXTRACT(HOUR FROM tweet_created_at)').reorder('EXTRACT(HOUR from tweet_created_at)').count
  end

end
