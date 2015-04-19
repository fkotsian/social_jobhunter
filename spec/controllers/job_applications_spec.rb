require 'spec_helper'

module Jobs
  describe JobApplicationsController do

    let(:user) { FactoryGirl.create(:user) }
    let(:job)  { FactoryGirl.create(:job)  }
    before(:all) do
      # session[:user_id] = user.id
    end
    
  
    describe "CREATE new application" do
      it "creates a valid job_application" do
        expect{
          post :create, 
            prefix: 'user/jobs',
            job_id: job.id,
            job_application: FactoryGirl.attributes_for(:job_application)
        }.to change(JobApplication, :count).by(1)
      end

      it "creates a new Job if one does not exist" do
        expect{
          post :create,
          prefix: 'user/jobs',
          job_id: job.id,
            job_application: FactoryGirl.attributes_for(:job_application)
        }.to change(Job, :count).by(1)
      end
    
      it "does not create a new Job if one does already exist" do
        expect{
          post :create,
          prefix: 'user/jobs',
          job_id: job.id,
            job_application: 
              FactoryGirl.create(:application_to_existing_job)
        }.to_not change(Job, :count)
      end
    
    end
  end
end