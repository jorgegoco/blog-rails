# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Seeding development database...'
dean = User.create(email: 'r@gmail.com',
                             password: '999999',
                             password_confirmation: '999999',
                             first_name: 'Rauru',
                             last_name: 'Pereiro',
                             role: User.roles[:admin])

john = User.create(email: 'z@gmail.com',
                             password: '888888',
                             password_confirmation: '888888',
                             first_name: 'Zelda',
                             last_name: 'DoPazo')
Address.create(street: '123 Main St',
                         city: 'Anytown',
                         state: 'CA',
                         zip: '12345',
                         country: 'USA',
                         user: dean)
Address.create(street: '123 Main St',
                        city: 'Anytown',
                        state: 'OH',
                        zip: '12345',
                        country: 'USA',
                        user: john)
elapsed = Benchmark.measure do
  posts = []

  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: dean)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: john)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"