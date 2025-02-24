# Clear existing data (optional)
User.destroy_all
Post.destroy_all

# Create 2 users
users = []

(1..5).to_a.each do |index|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username,
    email: "user#{index}@example.com",
    password: 'password'
  )
  users << user
end


# Create 10 posts for each user
users.each do |user|
  10.times do
    start_time = 24.hours.ago
    end_time = 30.minutes.ago
    created_at_time = Time.at(rand(start_time.to_f..end_time.to_f))

    post = Post.create!(
      user_id: user.id,
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph(sentence_count: (5..20).to_a.sample),
      created_at: created_at_time 
    )
  end
end

puts "✅ Seed data created: #{User.count} users and #{Post.count} posts!"
