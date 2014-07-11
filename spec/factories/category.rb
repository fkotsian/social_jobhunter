require 'faker'

FactoryGirl.define do
  factory :category do |f|
    
    factory :sales do |f|
      f.name   "Sales"
    end
    
    factory :biz_dev do |f|
      f.name  "Biz Dev"
    end
    
    factory :engineering do |f|
      f.name  "Engineering"
    end

  end
end