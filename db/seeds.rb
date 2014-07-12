# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'frank@test.com', password: 'aaaabbbb', password_confirmation: 'aaaabbbb')

JobCategory.create(name: "Sales")
JobCategory.create(name: "Biz Dev")
JobCategory.create(name: "Engineering")
JobCategory.create(name: "Marketing")
JobCategory.create(name: "PR")
JobCategory.create(name: "Product Management")

10.times do
  FactoryGirl.create :job
end