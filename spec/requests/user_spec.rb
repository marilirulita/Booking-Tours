require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    before(:all) do
      User.destroy_all
      Tour.destroy_all
      UserTour.destroy_all
    end
    let(:response_body) { JSON.parse(response.body) }
    context 'Create a new user' do
      it 'Sending complete data' do
        post '/users',
             params: {
               name: 'Santiago',
               email: 'test@test.com',
               password: 'password'
             }
        expect(response).to have_http_status(201)
        expect(response_body).to include('id')
        expect(response_body['email']).to match(/test@test/)
        expect(response_body['name']).to match(/Santiago/)
      end
    end

    context 'Create a new user' do
      it 'Sending incomplete data' do
        post '/users',
             params: {
               email: 'test@test.com',
               password: 'password'
             }
        expect(response).to have_http_status(422)
      end
    end
  end
end
