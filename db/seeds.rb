# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Make Users
[1..100].each do |name|
  User.create
end

# Make School Filters
[1..100].each do |name|
  SchoolFilter.create(rating)
end
