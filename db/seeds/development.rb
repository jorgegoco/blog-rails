puts 'Seeding development database...'
rauru = User.first_or_create!(email: 'r@gmail.com',
                             password: '999999',
                             password_confirmation: '999999',
                             first_name: 'Rauru',
                             last_name: 'González',
                             role: User.roles[:admin])

zelda = User.first_or_create!(email: 'z@gmail.com',
                             password: '888888',
                             password_confirmation: '888888',
                             first_name: 'Zelda',
                             last_name: 'Conde')
Address.first_or_create!(street: '123 Main St',
                         city: 'Anytown',
                         state: 'OH',
                         zip: '12345',
                         country: 'USA',
                         user: rauru)
Address.first_or_create(street: '321 Main St',
                        city: 'Anytown',
                        state: 'OH',
                        zip: '12345',
                        country: 'USA',
                        user: zelda)
elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: rauru)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: zelda)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"