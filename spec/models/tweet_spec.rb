require 'spec_helper'

describe Tweet do
  
  it 'should not be valid without a tweet_id' do 

    tweet = FactoryGirl.build(:tweet, :tweet_id => nil)
    tweet.should_not be_valid

  end

  it 'should not be valid without a raw field' do 

    tweet = FactoryGirl.build(:tweet, :raw => nil)
    tweet.should_not be_valid

  end

  it 'should not be valid without a content field' do 

    tweet = FactoryGirl.build(:tweet, :content => nil)
    tweet.should_not be_valid

  end

  it 'should not be valid without a username' do 

    tweet = FactoryGirl.build(:tweet, :username => nil)
    tweet.should_not be_valid

  end

  it 'should not be valid without a followers field' do 

    tweet = FactoryGirl.build(:tweet, :followers => nil)
    tweet.should_not be_valid

  end

  it 'should not be valid without a tweet_created_at field' do 

    tweet = FactoryGirl.build(:tweet, :tweet_created_at => nil)
    tweet.should_not be_valid

  end

  describe '.build_from_json' do 

    before(:each) do 

      @json = '{"created_at": "Thu Mar 21 17:45:57 +0000 2013","id": 314795024158179300,"id_str": "314795024158179329","text": "@SocialBiblioCA Just added ours #Apps4Ottawa entry to the official site: http://t.co/e4Q3XdGe3g Again any is feedback more than welcome!","source": "<a href=\"http://itunes.apple.com/us/app/twitter/id409789998?mt=12\" rel=\"nofollow\">Twitter for Mac</a>","truncated": false,"in_reply_to_status_id": null,"in_reply_to_status_id_str": null,"in_reply_to_user_id": 494211421,"in_reply_to_user_id_str": "494211421","in_reply_to_screen_name": "SocialBiblioCA","user": {"id": 265998020,"id_str": "265998020","name": "Max Neuvians","screen_name": "maxneuvians","location": "Ottawa, ON","description": "Interested in social discovery of information, web and library metrics. Co-founded http://t.co/aLGTsenwP5","url": null,"entities": {"description": {"urls": [{"url": "http://t.co/aLGTsenwP5","expanded_url": "http://Social-Biblio.ca","display_url": "Social-Biblio.ca","indices": [83,105]}]}},"protected": false,"followers_count": 69,"friends_count": 53,"listed_count": 5,"created_at": "Mon Mar 14 13:36:30 +0000 2011","favourites_count": 0,"utc_offset": -14400,"time_zone": "Eastern Time (US & Canada)","geo_enabled": false,"verified": false,"statuses_count": 135,"lang": "en","contributors_enabled": false,"is_translator": false,"is_translation_enabled": false,"profile_background_color": "C6E2EE","profile_background_image_url": "http://abs.twimg.com/images/themes/theme2/bg.gif","profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme2/bg.gif","profile_background_tile": false,"profile_image_url": "http://pbs.twimg.com/profile_images/3144117814/57f8054930b432fd9f07559bffe836c1_normal.jpeg","profile_image_url_https": "https://pbs.twimg.com/profile_images/3144117814/57f8054930b432fd9f07559bffe836c1_normal.jpeg","profile_link_color": "1F98C7","profile_sidebar_border_color": "C6E2EE","profile_sidebar_fill_color": "DAECF4","profile_text_color": "663B12","profile_use_background_image": true,"default_profile": false,"default_profile_image": false,"following": false,"follow_request_sent": false,"notifications": false},"geo": null,"coordinates": null,"place": null,"contributors": null,"retweet_count": 0,"favorite_count": 0,"entities": {"hashtags": [{"text": "Apps4Ottawa","indices": [32,44]}],"symbols": [],"urls": [{"url": "http://t.co/e4Q3XdGe3g","expanded_url": "http://www.apps4ottawa.ca/en/apps/49","display_url": "apps4ottawa.ca/en/apps/49","indices": [73,95]}],"user_mentions": [{"screen_name": "SocialBiblioCA","name": "Social Biblio CA","id": 494211421,"id_str": "494211421","indices": [0,15]}]},"favorited": false,"retweeted": false,"possibly_sensitive": false,"lang": "en"}'
      @tweet = Tweet.new
      @tweet.build_from_json(@json)

    end

    it 'retains a copy of the tweet in the raw field' do 
      @tweet.raw.should eql @json
    end

    it 'copies the tweet_id to tweet_id' do 
      @tweet.tweet_id.should eql("314795024158179329")
    end

    it 'copies the text to content' do 
      @tweet.content.should eql("@SocialBiblioCA Just added ours #Apps4Ottawa entry to the official site: http://t.co/e4Q3XdGe3g Again any is feedback more than welcome!")
    end

    it 'copies the user screen_name to username' do 
      @tweet.username.should eql("maxneuvians")
    end

    it 'copies the follower_count to followers' do 
      @tweet.followers.should eql(69)
    end

    it 'copies the follower_count to followers as an integer' do 
      @tweet.followers.should be_a(Integer)
    end

    it 'creates an array of hashtags' do 
      @tweet.hashtags.should eql(['Apps4Ottawa'])
    end

    it 'creates an array of urls' do 
      @tweet.urls.should eql(['http://www.apps4ottawa.ca/en/apps/49'])
    end

    it 'creates an array of mentions' do 
      @tweet.mentions.should eql(['SocialBiblioCA'])
    end

    it 'copies in_reply_to_screen_name to in_reply_to' do 
      @tweet.in_reply_to.should eql("SocialBiblioCA")
    end

    it 'parses created_at into tweet_created_at' do 
      @tweet.tweet_created_at.strftime("%F %T").should eql("2013-03-21 17:45:57")
    end

    it 'saves the new tweet' do 
      @tweet.id.should_not eql(nil)
    end

  end

  describe '.get_library_tweets_for_today' do 

    before(:each) do
      @library = FactoryGirl::create(:library)
      @tweet = FactoryGirl::create(:tweet)
    end

    it 'loads tweets by libaries with todays date' do 

      Timecop.travel(@tweet.tweet_created_at)
      tweets = Tweet.get_library_tweets_for_today
      expect(tweets).to include(@tweet)
      Timecop.return

    end

    it 'loads does not load tweets by libaries older than todays date' do 

      tweets = Tweet.get_library_tweets_for_today
      expect(tweets).to_not include(@tweet)

    end

  end

  describe '.get_library_tweets_for_today_by_hour' do 

    before(:each) do 
      @library = FactoryGirl::create(:library)
      @tweet_one = FactoryGirl::create(:tweet, :tweet_created_at => Time.zone.parse("Thu Mar 21 17:45:57 +0000 2013"))
      @tweet_two = FactoryGirl::create(:tweet, :tweet_created_at => Time.zone.parse("Thu Mar 21 17:45:57 +0000 2013"))
      @tweet_three = FactoryGirl::create(:tweet, :tweet_created_at => Time.zone.parse("Thu Mar 21 16:45:57 +0000 2013"))
    end

    it 'loads tweets by libaries with todays date and splits them into their hours' do 

      Timecop.travel(@tweet_one.tweet_created_at)
      tweets = Tweet.get_library_tweets_for_today_by_hour
      expect(tweets[17.0]).to eql(2)
      expect(tweets[16.0]).to eql(1)
      Timecop.return

    end

    it 'loads does not load tweets by libaries older than todays date' do 

      tweets = Tweet.get_library_tweets_for_today_by_hour
      expect(tweets).to_not include(@tweet_one)

    end

  end

end
