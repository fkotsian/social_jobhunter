require 'spec_helper'

describe JobApplicationsController do

  let(:user) { FactoryGirl.create(:user) }
  before(:all) do
    navigate new_session_path
    
  
  describe "CREATE new application" do
    it "creates a valid job_application" do
      expect{
        post :create, 
        job_application: FactoryGirl.attributes_for(:job_application)
      }.to change(JobApplication, :count).by(1)
    end

    it "creates a new Job if one does not exist" do
      expect{
        post :create,
        job_application: FactoryGirl.attributes_for(:job_application)
      }.to change(Job, :count).by(1)
    end
    
    it "does not create a new Job if one does already exist"
      expect{
        post :create,
        job_application: FactoryGirl.attributes_for(:same_job)
      }.to_not change(Job, :count)
  end
end