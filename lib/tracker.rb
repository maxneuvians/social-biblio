ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, "config", "environment")

Daemons.run_proc('tracker') do 

  ActiveRecord::Base.connection.reconnect!
  ActiveRecord::Base.logger = Logger.new(File.open(File.join(root, "/log/stream.log"), 'w+'))

  @keywords = []
  @ids      = []

  Library.all.each do |library|
    @keywords.push "@#{library.username}"
    @ids.push library.twitter_id
  end

  TweetStream::Client.new.filter( :track => @keywords, :follow => @ids) do |status|
    tweet = Tweet.new
    tweet.build_from_json(status.to_json)
  end

end
