class UserTour < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :tour, class_name: 'Tour', foreign_key: 'tour_id'

  validates :persons_number, presence: true,
                             numericality: { only_integer: true,
                                             greater_than_or_equal_to: 1,
                                             alert: 'You should provide a valid number of persons' }
end
