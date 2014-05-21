# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    raw "MyText"
    tweet_id "MyString"
    content "MyText"
    username "MyString"
    in_reply_to "MyString"
    followers 0
    hashtags []
    urls []
    mentions []
    tweet_created_at Time.now
  end
end
