require 'swagger_helper'

RSpec.describe 'auth/login', type: :request do
  path '/auth/login' do
    post('create session') do
      tags 'Authentication'
      description 'Authenticates an user and returns a jwt token'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(200, 'successful') do
        let(:user) { User.create(name: 'User', email: 'test@test.com', password: 'password') }
        let(:params) { { email: user.email, password: user.password } }
        example 'application/json', :successfull_login, {
          token: 'ASDFARasdfasdf13ADSFAGASD',
          user: {
            name: 'User',
            user_id: 1
          }
        }
        run_test!
      end

      response(401, 'Invalid params') do
        let(:params) { { email: 'other@gmail.com', password: 'password' } }

        example 'application/json', :invalid_credentials, {
          error: 'Wrong email or password.'
        }
        run_test!
      end
    end
  end
end
