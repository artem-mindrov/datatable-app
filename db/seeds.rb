# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.create! :name => 'Peter', :level => 1
user2 = User.create! :name => 'Sam', :level => 1
user3 = User.create! :name => 'Adam', :level => 2
user4 = User.create! :name => 'Justin', :level => 2

item1 = Item.create! :name => 'Candy', :level => 1
item2 = Item.create! :name => 'Pen', :level => 1
item3 = Item.create! :name => 'Cigar', :level => 2
item4 = Item.create! :name => 'Mask', :level => 2
item5 = Item.create! :name => 'Box', :level => 3