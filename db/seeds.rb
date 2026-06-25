# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
engineering = Team.create!(name: "Engineering")
marketing   = Team.create!(name: "Marketing")
sales       = Team.create!(name: "Sales")

john = Member.create!(
  first_name: "John",
  last_name: "Doe",
  city: "Lahore",
  state: "Punjab",
  country: "Pakistan",
  team: engineering
)

jane = Member.create!(
  first_name: "Jane",
  last_name: "Smith",
  city: "Karachi",
  state: "Sindh",
  country: "Pakistan",
  team: engineering
)

ali = Member.create!(
  first_name: "Ali",
  last_name: "Khan",
  city: "Islamabad",
  state: "ICT",
  country: "Pakistan",
  team: marketing
)

sara = Member.create!(
  first_name: "Sara",
  last_name: "Ahmed",
  city: "Faisalabad",
  state: "Punjab",
  country: "Pakistan",
  team: marketing
)

usman = Member.create!(
  first_name: "Usman",
  last_name: "Malik",
  city: "Multan",
  state: "Punjab",
  country: "Pakistan",
  team: sales
)

project1 = Project.create!(name: "Organization App")
project2 = Project.create!(name: "Marketing Website")
project3 = Project.create!(name: "Sales Dashboard")

project1.members << [john, ali]
project2.members << [jane, sara]
project3.members << [usman, ayesha]
