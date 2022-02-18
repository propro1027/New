# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# スクリプト　サンプル　user作成
# coding: utf-8
# User.create!(name: "admin",
# email: "admin@email.com",
# password: "password",
# password_cofirmation: "password"
# )

# 40.times do |n|
#   name = Faker::Name.name
#   email = "ex-#{n+1}@email.com"
#   password = "password"
#   User.create!(name: name,
#   email: email,
# password: password,
# password_cofirmation: password
# )
# end  

User.create!(name: "Sample User",
  email: "sample@email.com",
  department: "オーナー",
  password: "password",
  password_confirmation: "password",
  admin: true)

60.times do |n|
name  = Faker::Name.name
email = "sample-#{n+1}@email.com"
department =  "部署-#{n+1}",
password = "password"
User.create!(name: name,
    email: email,
    department: department,
    password: password,
    password_confirmation: password)
end