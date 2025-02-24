# Clear existing data (optional)
User.destroy_all
Post.destroy_all

# Create 2 users
users = []

  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username,
    email: 'user@example.com',
    password: 'password' # Adjust as needed
  )
  users << user

  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username,
    email: 'user2@example.com',
    password: 'password' # Adjust as needed
  )
  users << user


# Create 10 posts for each user
users.each do |user|
  10.times do
    Post.create!(
      user_id: user.id,
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph(sentence_count: 10)
    )
  end
end

puts "✅ Seed data created: #{User.count} users and #{Post.count} posts!"
