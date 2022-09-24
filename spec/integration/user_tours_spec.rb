require 'swagger_helper'

describe 'Reservations API' do
  let(:response_body) { JSON.parse(response.body) }
    let(:user) { User.create(name: "user", email: "user@gmail.com", password: 'password') }
    let(:token) do
        post "/auth/login",
             params: { email: user.email, password: user.password },
             as: :json
        response_body['token']
      end
      let(:tour) { Tour.create(title:"title", duration:2, city:"City", description:"Description", cost:2, photo:"asdf", user_id:user.id)}

  path '/user_tours' do
    get 'Retrieves reservations' do
      tags 'Reservations'
      description 'Retrieves reservations for a user'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: 'Authorization', in: :header, type: :string
            response(200, 'Successful') do

                let("Authorization") { token }
                example 'application/json', :successful, {
                    data: [
                      {
                        tour: {
                            id: 1,
                            title: "First Tour",
                            duration: "2.0",
                            city: "Mansoura",
                            description: "In this tour we will visit x and ...",
                            cost: "500.0",
                            photo: "https://www.mans.edu.eg/images/album/mansoura-city/mc-nile.jpg",
                            user_id: 1,
                            created_at: "2022-09-22T00:27:45.651Z",
                            updated_at: "2022-09-22T00:27:45.651Z"
                        },
                        persons_number: 3,
                        reservation_date: "2022-10-22",
                        reservation_id: 1
                    },
                    {
                        tour: {
                            id: 2,
                            title: "Second Tour",
                            duration: "3.0",
                            city: "Sharm El Sheikh",
                            description: "In this tour we will visit y and ...",
                            cost: "600.0",
                            photo: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fc/ed/sharm-el-sheikh.jpg?w=700&h=500&s=1",
                            user_id: 2,
                            created_at: "2022-09-22T00:27:45.670Z",
                            updated_at: "2022-09-22T00:27:45.670Z"
                        },
                        persons_number: 2,
                        reservation_date: "2022-10-22",
                        reservation_id: 2
                    }
                  ]
                }
                run_test!
            end
          end
        end

end
