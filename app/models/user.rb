class User < ApplicationRecord
  has_secure_password
  
  has_many :messages, dependent: :destroy
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
