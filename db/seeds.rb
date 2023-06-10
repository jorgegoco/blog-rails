# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "r@gmail.com", password: "999999", password_confirmation: "999999")

10.times do |x|
  Post.create(title: "Post #{x}", body: "This is the body of post #{x}", user_id: User.first.id)
end
