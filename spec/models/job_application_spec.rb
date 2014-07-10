require 'spec_helper'

describe JobApplication do

  let(:app)   { FactoryGirl.create(:job_application) }
  
  context "validations" do
    it "has a valid factory" do
      FactoryGirl.create(:job_application).should be_valid
    end
    it "belongs to a job" do
      expect(app.job_id).to be_a Integer
    end
    it "belongs to an applicant" do
      expect(app.applicant.id).to be_a Integer
    end
    it "has a status" do
      expect(app.status).to eq("Applied")
    end
  end
  
  context "create a new application" do
    it "creates a job if necessary"
  end
  
end