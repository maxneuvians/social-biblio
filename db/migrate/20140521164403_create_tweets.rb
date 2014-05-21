class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|

      t.text :raw
      t.string :tweet_id
      t.text :content
      t.string :username, index: true
      t.string :in_reply_to, index: true
      t.integer :followers
      t.string :hashtags, array: true, default: []
      t.string :urls, array: true, default: []
      t.string :mentions, array: true, default: []
      t.time :tweet_created_at

      t.timestamps
    end

    add_index  :tweets, :hashtags, using: 'gin'
    add_index  :tweets, :urls, using: 'gin'
    add_index  :tweets, :mentions, using: 'gin'

  end
end
