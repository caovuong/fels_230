# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Hoang Thao",
  email: "hoangthaomta5@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true)
(1..100).each do |category_id|
  Category.create(name: "Category #{category_id}")
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.org"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
