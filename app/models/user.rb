class User < ApplicationRecord
  has_many :tours, foreign_key: 'user_id', dependent: :destroy
  has_many :user_tours, foreign_key: 'user_id', dependent: :delete_all

  validates :name, presence: true
  has_secure_password

  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true
end
