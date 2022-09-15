require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Testing User validations and methods' do
    before :all do
      @user = User.new(name: 'Mahmoud')
      @user.save
    end

    after :all do
      User.destroy_all
    end

    it 'name should be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end
  end
end