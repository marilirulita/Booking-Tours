require 'rails_helper'

RSpec.describe Tour, type: :model do
  before :all do
    @user = User.new(name: 'Mahmoud')
    @user.save
    @tour = Tour.create(title: 'First Tour', description: 'In this tour we will visit x and ...', user_id: @user.id,
                        cost: 500)
  end

  after :all do
    User.destroy_all
    Tour.destroy_all
  end

  context 'Testing Tour required columns' do
    it 'title should be present' do
      @tour.title = nil
      expect(@tour).to_not be_valid
    end

    it 'description should be present' do
      @tour.description = nil
      expect(@tour).to_not be_valid
    end

    it 'cost should be present' do
      @tour.cost = nil
      expect(@tour).to_not be_valid
    end

    it 'user_id should be present' do
      @tour.user_id = nil
      expect(@tour).to_not be_valid
    end
  end

  context 'Testing Tour types and limits validations' do
    it 'title must not exceed 100 characters' do
      @tour.title = 'h' * 101
      expect(@tour).to_not be_valid
    end

    it 'description must not exceed 500 characters' do
      @tour.description = 'h' * 501
      expect(@tour).to_not be_valid
    end

    it 'cost should be a number' do
      @tour.cost = 'Ten'
      expect(@tour).to_not be_valid
    end

    it 'cost should be non-negative number' do
      @tour.cost = -4
      expect(@tour).to_not be_valid
    end
  end
end
