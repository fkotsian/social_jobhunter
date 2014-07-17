require 'faker'

FactoryGirl.define do
  factory :company do |f|
    f.name          { Faker::Company.name }
    f.description   { Faker::Company.bs }
    f.company_size  { Faker::Number.number(5) }
    f.industry      { Faker::Commerce.department }
    f.company_url   { Faker::Internet.url }
  end
end