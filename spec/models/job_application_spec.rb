require 'spec_helper'

describe JobApplication do
  
  let(:applicant) { FactoryGirl.create(:user) }
  let(:job)       { FactoryGirl.create(:job) }

  it "has a valid factory" do
    FactoryGirl.create(:job_application).should be_valid
  end
  it "belongs to a job"
  it "belongs to an applicant"
  it "has a status"
  
  context "create a new application" do
    it "creates a job if necessary"
  end
end