# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.create(name: "Mahmoud")
user2 = User.create(name: "Alex")
user3 = User.create(name: "Mar")

tour1 = Tour.create(title: "First Tour", description: "In this tour we will visit x and ...", user_id: user1.id, cost: 500)
tour2 = Tour.create(title: "Second Tour", description: "In this tour we will visit y and ...", user_id: user2.id, cost: 600)

UserTour.create(user_id: user1.id, tour_id: tour1.id, persons_number: 3)
UserTour.create(user_id: user1.id, tour_id: tour2.id, persons_number: 2)
UserTour.create(user_id: user2.id, tour_id: tour2.id, persons_number: 1)