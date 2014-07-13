# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'frank@test.com', password: 'aaaabbbb', password_confirmation: 'aaaabbbb')

JobCategory.create(name: "sales", display_name: "Sales")
JobCategory.create(name: "biz_dev", display_name: "Biz Dev")
JobCategory.create(name: "engineering", display_name: "Engineering")
JobCategory.create(name: "marketing", display_name: "Marketing")
JobCategory.create(name: "pr", display_name: "PR")
JobCategory.create(name: "product_management", display_name: "Product Management")

10.times do
  FactoryGirl.create :job
end