require 'swagger_helper'

RSpec.describe 'tours', type: :request do
  let(:response_body) { JSON.parse(response.body) }
  let(:user) { User.create(name: 'user', email: 'user@gmail.com', password: 'password') }
  let(:token) do
    post '/auth/login',
         params: { email: user.email, password: user.password },
         as: :json
    response_body['token']
  end
  let(:params) do
    { tour: { title: 'title', duration: 2, city: 'City', description: 'Description', cost: 2, photo: 'asdf',
              user_id: user.id } }
  end
  path '/tours' do
    get('get list of tours') do
      tags 'Tour'
      description 'List all tours'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string
      response(200, 'Successful') do
        let('Authorization') { token }
        example 'application/json', :successful, [
          {
            id: 1,
            title: 'Tour Title',
            duration: '3.0',
            city: 'City',
            description: 'Description',
            cost: '100.0',
            photo: 'https://image.jpg',
            user_id: 1,
            created_at: '2022-09-21T15:41:25.060Z',
            updated_at: '2022-09-21T15:41:25.060Z'
          },
          {
            id: 2,
            title: 'Tour Title',
            duration: '3.0',
            city: 'City',
            description: 'Description',
            cost: '100.0',
            photo: 'https://image.jpg',
            user_id: 2,
            created_at: '2022-09-21T15:41:25.060Z',
            updated_at: '2022-09-21T15:41:25.060Z'
          }
        ]
        run_test!
      end
    end

    post('New tour') do
      tags 'Tour'
      consumes 'application/json'
      description 'Create a new tour'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :tour, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          duration: { type: :number },
          city: { type: :string },
          description: { type: :string },
          cost: { type: :number },
          photo: { type: :string },
          user_id: { type: :integer }
        },
        required: %w[title duration city description cost photo user_id]
      }
      response(201, 'Successful') do
        let(:tour) do
          { title: 'title', duration: 2, city: 'City', description: 'Description', cost: 2, photo: 'asdf',
            user_id: user.id }
        end
        let('Authorization') { token }

        example 'application/json', :successful,
                {
                  id: 1,
                  title: 'Tour Title',
                  duration: '3.0',
                  city: 'City',
                  description: 'Description',
                  cost: '100.0',
                  photo: 'https://image.jpg',
                  user_id: 1,
                  created_at: '2022-09-21T15:41:25.060Z',
                  updated_at: '2022-09-21T15:41:25.060Z'
                }
        run_test!
      end
    end
  end

  path '/tours/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    delete('delete tours') do
      tags 'Tour'
      description 'Delete a tour'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string

      response(204, 'successful') do
        let('Authorization') { token }
        let(:id) do
          Tour.create(title: 'title', duration: 2, city: 'City', description: 'Description', cost: 2, photo: 'asdf',
                      user_id: user.id).id
        end
        run_test!
      end
    end
  end

  path '/tours/{id}' do
    get('get specific tour') do
      tags 'Tour'
      description 'Get a tour'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: 'id', in: :path, type: :string, description: 'id'

      response(200, 'successful') do
        let('Authorization') { token }
        let(:id) do
          Tour.create(title: 'title', duration: 2, city: 'City', description: 'Description', cost: 2, photo: 'asdf',
                      user_id: user.id).id
        end
        run_test!
      end
    end
  end
end
