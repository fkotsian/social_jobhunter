module Jobs
  FactoryGirl.define do
    factory :job_application do |f|
      f.applicant_id  { FactoryGirl.create(:user).id }
      f.job_id { FactoryGirl.create(:job).id }
  
      factory :application_to_existing_job do |f|
        f.job_id        1
      end
  
      factory :screened_application do |f|
        f.status        "Screened"
      end
  
      factory :interviewed_application do |f|
        f.status        "Interviewed"
      end
  
      factory :offered_application do |f|
        f.status        "Offered"
      end
  
      factory :accepted_application do |f|
        f.status        "Accepted"
      end
  
      factory :rejected_application do |f|
        f.status        "Rejected"
      end
    end
  end
end