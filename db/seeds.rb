# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  Question.create({title: Faker::Company.bs,
                   body:  Faker::Lorem.paragraph })
end

print Cowsay::say("Created 100 questions!")

tags = ["science", "programming", "cats", "pyjamas", "gems"]

tags.each do |tag|
  Tag.create(name: tag)
end

print Cowsay::say("Created #{tags.length} tags!")
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
