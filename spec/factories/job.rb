require 'faker'

FactoryGirl.define do
  factory :job do |f|
    f.title           { Faker::Company.name }
    f.company_id      { FactoryGirl.create(:company).id }
    f.job_category_id 1
    f.url             { Faker::Internet.url }
    f.salary_bottom   { Faker::Number.number(2) }
    f.salary_top      { Faker::Number.number(6) }
  end
end