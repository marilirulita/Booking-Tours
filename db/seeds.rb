# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
user = User.create(name: "Visit", email: "visit@email.com", password: "visit123")
Tour.create(title: "Viaje San Felipe", duration: 2, city: "San Felipe" , description: "Viaje a playas de san felipe por dos semanas", cost: 100, photo: "https://waki-exp.com/wp-content/uploads/2022/05/10-de-mejores-playas-de-Mexico-poco-conocidas-pero-hermosas.jpg", user_id: user.id)
Tour.create(title: "Viaje Rosarito", duration: 1, city: "Rosarito", description: "Viaje a rosarito de una semana", cost: 150, photo: "https://www.expedia.mx/stories/wp-content/uploads/2022/05/playas-para-ninos-mexico-xpu-ha-riviera-maya-scaled.jpg", user_id: user.id)
