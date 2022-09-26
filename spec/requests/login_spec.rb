require 'rails_helper'

RSpec.describe 'Logins', type: :request do
  describe 'POST /auth/login' do
    before(:all) do
      User.destroy_all
      Tour.destroy_all
      UserTour.destroy_all
    end
    let(:response_body) { JSON.parse(response.body) }
    let(:user) { User.create(name: 'Santiago2', email: 'test@test.com', password: 'password') }
    context 'sending valid credentials' do
      it 'logins the user succesfully' do
        post '/auth/login',
             params: {
               email: user.email,
               password: 'password'
             }

        expect(response).to have_http_status(:ok)
        expect(response_body['user']['name']).to eq user.name
        expect(response_body).to include('token')
      end
    end

    context 'sending invalid credentials' do
      it 'user should be rejected' do
        post '/auth/login',
             params: {
               email: user.email,
               password: 'invalid'
             }
        expect(response).to have_http_status(401)
        expect(response_body['error']).to match(/Wrong email or password/)
        expect(response_body).not_to include('token')
      end
    end
  end
end
