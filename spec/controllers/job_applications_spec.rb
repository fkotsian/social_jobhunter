require 'spec_helper'
require_relative '../helpers/request_helpers'

describe JobApplicationsController, type: :request do
  include RequestHelpers

  let(:user)    {FactoryGirl.create(:user)}
  let(:company) {FactoryGirl.create(:company)}
  before do
    sign_in_as(user)
  end

  describe "CREATE new application" do
    it "creates a valid job_application" do
      params = {
        job_application: {
          applicant_id: user.id,
          job_attributes: {
            title: 'default job',
            company_id: company.id
          }
        }
      }
      
      expect{
        post "/user/job_applications", 
              params
      }.to change(JobApplication, :count).by(1)
    end

    context 'when the associated Job does not exist' do
      it "creates a new Job" do
        params = {
          job_application: {
            applicant_id: user.id,
            job_attributes: {
              title: 'default job',
              company_id: company.id
            }
          }
        }
        
        expect{
          post "/user/job_applications", 
                params
        }.to change(Job, :count).by(1)
      end
    end
  
    context 'when the Job to be associated does exist' do
      before do
        Job.create(title: 'job_title', 
                   company_id: company.id)
      end
      
      it "does not create a new Job" do
        expect(Job.count).to eq 1
        expect{
          post "/user/job_applications",
            job_application: {
              applicant_id: user.id,
              job_attributes: {
                title: 'job_title',
                company_id: company.id
              }
            }
        }.to_not change(Job, :count)
      end
      
      it 'the application references the existing job' do
        post "/user/job_applications",
          job_application: {
            applicant_id: user.id,
            job_attributes: {
              title: 'job_title',
              company_id: company.id
            }
          }

        app = JobApplication.first
        job = Job.find_by_title_and_company_id('job_title', company.id)
        expect(app.job).to eq job
      end
    end
  end
end