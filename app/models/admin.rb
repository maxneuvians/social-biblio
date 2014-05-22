class Admin < ActiveRecord::Base

  has_secure_password

  validates :email, :presence => true, :uniqueness => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, confirmation: true, length: { minimum: 8 }, on: :create
  validates :password_digest, :presence => true

end
