class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :twitter_id
      t.string :username

      t.timestamps
    end
  end
end
