require 'faker'

FactoryGirl.define do
  factory :job do |f|
    f.title           { Faker::Internet.email }
    f.company_id      { FactoryGirl.create(:company).id }
    f.category_id     1
    f.url             { Faker::Internet.url }
    f.salary_bottom   0
    f.salary_top      1_000_000
  end
end