require 'swagger_helper'

describe 'Reservations API' do
  let(:response_body) { JSON.parse(response.body) }
  let(:user) { User.create(name: 'user', email: 'user@gmail.com', password: 'password') }
  let(:token) do
    post '/auth/login',
         params: { email: user.email, password: user.password },
         as: :json
    response_body['token']
  end
  let(:tour) do
    Tour.create(title: 'title', duration: 2, city: 'City', description: 'Description', cost: 2, photo: 'asdf',
                user_id: user.id)
  end

  path '/user_tours' do
    get 'Retrieves reservations' do
      tags 'Reservations'
      description 'Retrieves reservations for a user'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string
      response(200, 'Successful') do
        let('Authorization') { token }
        example 'application/json', :successful,
                [
                  {
                    tour: {
                      id: 1,
                      title: 'First Tour',
                      duration: '2.0',
                      city: 'Mansoura',
                      description: 'In this tour we will visit x and ...',
                      cost: '500.0',
                      photo: 'https://www.mans.edu.eg/images/album/mansoura-city/mc-nile.jpg',
                      user_id: 1,
                      created_at: '2022-09-22T00:27:45.651Z',
                      updated_at: '2022-09-22T00:27:45.651Z'
                    },
                    persons_number: 3,
                    reservation_date: '2022-10-22',
                    reservation_id: 1
                  },
                  {
                    tour: {
                      id: 2,
                      title: 'Second Tour',
                      duration: '3.0',
                      city: 'Sharm El Sheikh',
                      description: 'In this tour we will visit y and ...',
                      cost: '600.0',
                      photo: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fc/ed/sharm-el-sheikh.jpg?w=700&h=500&s=1',
                      user_id: 2,
                      created_at: '2022-09-22T00:27:45.670Z',
                      updated_at: '2022-09-22T00:27:45.670Z'
                    },
                    persons_number: 2,
                    reservation_date: '2022-10-22',
                    reservation_id: 2
                  }
                ]
        run_test!
      end
    end

    post 'New reservation' do
      tags 'Reservations'
      consumes 'application/json'
      description 'Create a new reservation'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :user_tour, in: :body, schema: {
        type: :object,
        properties: {
          persons_number: { type: :integer },
          reservation_date: { type: :string },
          user_id: { type: :integer },
          tour_id: { type: :integer }
        },
        required: %w[persons_number tour_id user_id]
      }
      response(201, 'Successful') do
        let(:user_tour) do
          { tour_id: tour.id, persons_number: 2, reservation_date: '2022-10-21', user_id: user.id }
        end
        let('Authorization') { token }

        example 'application/json', :successful, {
          id: 1,
          reservation_date: '2022-10-21',
          persons_number: 2,
          user_id: 1,
          tour_id: 1,
          created_at: '2022-09-21T15:41:25.060Z',
          updated_at: '2022-09-21T15:41:25.060Z'
        }
        run_test!
      end
    end
  end

  path '/user_tours/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    delete('delete reservation') do
      tags 'Reservations'
      description 'Delete a reservation'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: 'Authorization', in: :header, type: :string

      response(204, 'successful') do
        let('Authorization') { token }
        let(:id) do
          UserTour.create(persons_number: 2, reservation_date: '2022-10-21', tour_id: tour.id, user_id: user.id).id
        end
        run_test!
      end
    end
  end
end
