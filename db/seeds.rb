# Clear existing data (optional)
Message.destroy_all
ConversationUser.destroy_all
Conversation.destroy_all
Post.destroy_all
User.destroy_all

# Create 5 users
users = []

(1..5).each do |index|
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

    Post.create!(
      user_id: user.id,
      content: Faker::Lorem.paragraph(sentence_count: rand(5..20)),
      created_at: created_at_time
    )
  end
end

# Find user1 and user2
user1 = User.find_by(email: "user1@example.com")
user2 = User.find_by(email: "user2@example.com")

# Create a conversation between user1 and user2
conversation = Conversation.create!
conversation.users << [ user1, user2 ]

# Add 10 messages to the conversation
10.times do |i|
  start_time = 24.hours.ago
  end_time = 30.minutes.ago
  created_at_time = Time.at(rand(start_time.to_f..end_time.to_f))
  from_user, to_user = i.even? ? [ user1, user2 ] : [ user2, user1 ]

  Message.create!(
    conversation: conversation,
    from_user: from_user,
    to_user: to_user,
    content: Faker::Lorem.sentence(word_count: rand(5..15)),
    is_read: true,
    created_at: created_at_time
  )
end

puts "✅ Seed data created: #{User.count} users, #{Post.count} posts, 1 conversation, and #{Message.count} messages!"
