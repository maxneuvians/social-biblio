namespace :import do

  desc "import libraries"
  task libraries: :environment do
    File.open('lib/assets/accounts.json', "r") do |file|
      i = 1
      file.each do |line|
        account = JSON.parse line
        Library.create({:twitter_id => account["twitter_id"], :username => account["username"]})

        puts i
        i = i + 1 

      end
    end
  end
  
  desc "imports tweets"
  task :tweets, [:path] => [:environment] do |t, args|
    File.open(args[:path], "r") do |file|
      i = 1
      file.each do |line|
        
        tweet = Tweet.new
        tweet.build_from_json(line)

        puts i
        i = i + 1 

      end
    end
  end


end