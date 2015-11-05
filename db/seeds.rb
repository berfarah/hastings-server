# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user  = ENV["ADMIN_USER"] || "hastings"
email = ENV["ADMIN_EMAIL"] || "ber@bernardo.me"
pass  = ENV["ADMIN_PASSWORD"] || "admin123"

User.create!(username: user, email: email, password: pass)
