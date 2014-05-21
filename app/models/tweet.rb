class Tweet < ActiveRecord::Base

  validates :raw,               :presence => true
  validates :tweet_id,          :presence => true
  validates :content,           :presence => true
  validates :username,          :presence => true
  validates :followers,         :presence => true
  validates :tweet_created_at,  :presence => true


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

    self.save!

  end

end
