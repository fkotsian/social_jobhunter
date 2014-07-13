require 'faker'

FactoryGirl.define do
  factory :category do |f|
    
    factory :sales do |f|
      f.name          "sales"
      f.display_name  "Sales"
    end
    
    factory :biz_dev do |f|
      f.name          "biz_dev"
      f.display_name  "Business Development"
    end
    
    factory :engineering do |f|
      f.name          "engineering"
      f.display_name  "Engineering"
    end

  end
end