require 'swagger_helper'

RSpec.describe 'users', type: :request do
  path '/users' do
    post('create new user') do
      tags 'Authentication'
      description 'Create a new user'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response(201, 'successful') do
        let(:params) { { name: 'user', email: 'user@gmail.com', password: 'password' } }
        example 'application/json', :successfull_login, {
          id: 1,
          name: 'user',
          created_at: '2022-09-23T16:35:16.614Z',
          updated_at: '2022-09-23T16:35:16.614Z',
          email: 'user@gmail.com',
          password_digest: '$2a$12$Dqn9G4HpoJQu3xh6GCEGKOr6vuZJf8afop4SLPaexOTjfG04vn8c6'
        }
        run_test!
      end

      response(422, 'Invalid credentials') do
        let(:params) { { name: '', email: 'user@gmail.com', password: 'password' } }

        example 'application/json', :blank_name, {
          errors: [
            "Name can't be blank"
          ]
        }

        example 'application/json', :blank_email, {
          errors: [
            "Email can't be blank"
          ]
        }

        example 'application/json', :username_taken, {
          errors: [
            "Password can't be blank"
          ]
        }
        run_test!
      end
    end
  end
end
