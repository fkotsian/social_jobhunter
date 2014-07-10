FactoryGirl.define do
  factory :job_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
  end
  
  factory :screened_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
    f.status        "Screened"
  end
  
  factory :interviewed_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
    f.status        "Interviewed"
  end
  
  factory :offered_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
    f.status        "Offered"
  end
  
  factory :accepted_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
    f.status        "Accepted"
  end
  
  factory :rejected_application do |f|
    f.job_id        { FactoryGirl.create(:job).id }
    f.applicant_id  { FactoryGirl.create(:user).id }
    f.status        "Rejected"
  end
end