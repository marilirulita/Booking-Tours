class Tour < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :user_tours, dependent: :delete_all

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0, alert: 'Cost must be greater than 0' }
end
