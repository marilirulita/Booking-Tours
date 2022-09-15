require 'rails_helper'

RSpec.describe UserTour, type: :model do
  before :all do
    @user = User.new(name: 'Mahmoud')
    @user.save
    @tour = Tour.create(title: 'First Tour', description: 'In this tour we will visit x and ...', user_id: @user.id,
                        cost: 500)
    @user_tour = UserTour.create(user_id: @user.id, tour_id: @tour.id, persons_number: 3)
  end

  after :all do
    User.destroy_all
    Tour.destroy_all
    UserTour.destroy_all
  end

  context 'Testing UserTour validations and methods' do
    it 'user_id should be present' do
      @user_tour.user_id = nil
      expect(@user_tour).to_not be_valid
    end

    it 'tour_id should be present' do
      @user_tour.tour_id = nil
      expect(@user_tour).to_not be_valid
    end

    it 'persons_number should be present' do
      @user_tour.persons_number = nil
      expect(@user_tour).to_not be_valid
    end

    it 'persons_number should be integer' do
      @user_tour.persons_number = 2.5
      expect(@user_tour).to_not be_valid
    end

    it 'persons_number should be greater than or equal to 1' do
      @user_tour.persons_number = 0
      expect(@user_tour).to_not be_valid
    end
  end
end
