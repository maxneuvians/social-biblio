class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|

      t.text :raw
      t.string :tweet_id
      t.references :library, :default => 0, index: true
      t.text :content
      t.string :username, index: true
      t.string :in_reply_to, index: true
      t.integer :followers
      t.text :hashtags, array: true, default: []
      t.text :urls, array: true, default: []
      t.text :mentions, array: true, default: []
      t.datetime :tweet_created_at

      t.timestamps
    end

    add_index  :tweets, :hashtags, using: 'gin'
    add_index  :tweets, :urls, using: 'gin'
    add_index  :tweets, :mentions, using: 'gin'

  end
end
