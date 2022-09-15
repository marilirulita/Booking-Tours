class User < ApplicationRecord
  has_many :tours, foreign_key: 'user_id', dependent: :destroy
  has_many :user_tours, foreign_key: 'user_id', dependent: :delete_all

  validates :name, presence: true
end