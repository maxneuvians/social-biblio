class Library < ActiveRecord::Base

  validates :twitter_id,  :presence => true, :uniqueness => true
  validates :username,    :presence => true, :uniqueness => true

end
