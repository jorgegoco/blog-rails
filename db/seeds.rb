# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "r@gmail.com", 
            name: "rauru", 
            password: "999999", 
            password_confirmation: "999999",
            role: User.roles[:admin])
User.create(email: "z@gmail.com", 
            name: "zelda", 
            password: "888888", 
            password_confirmation: "888888")           

elapsed = Benchmark.measure do 
  posts = []
  rauru = User.first
  zelda = User.second           
  1000.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}", 
                       body: "Body #{x}", 
                       user: rauru)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                           user: zelda)
    end      
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Elapsed time is #{elapsed.real} seconds"
