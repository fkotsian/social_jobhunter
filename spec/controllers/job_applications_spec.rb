require 'spec_helper'
require_relative '../helpers/request_helpers'

describe JobApplicationsController, type: :request do
  include RequestHelpers
  
  let(:user)    {FactoryGirl.create(:user)}
  before do
    sign_in_as(user)
  end

  describe "CREATE new application" do
    context 'when all params are provided' do
      before do
        Company.create(name: 'defaultco')
      end
      it "creates a valid job_application" do
        params = {
          job_application: {
            applicant_id: user.id,
            job_attributes: {
              title: 'default job',
              company_attributes: {
                name: 'defaultco'
              }
            }
          }
        }
      
        expect{
          post "/user/job_applications", 
                params
        }.to change(JobApplication, :count).by(1)
      end
    end

    context 'when the associated Job does not exist' do
      it "creates a new Job" do
        params = {
          job_application: {
            applicant_id: user.id,
            job_attributes: {
              title: 'default job',
              company_attributes: {
                name: 'defaultco'
              } 
            }
          }
        }
        
        expect{
          post "/user/job_applications", 
                params
        }.to change(Job, :count).by(1)
      end
      
      context "and the job's Company does not exist" do
        it 'creates a new Company' do
          params = {
            job_application: {
              applicant_id: user.id,
              job_attributes: {
                title: 'default job',
                company_attributes: {
                  name: 'defaultco'
                }
              }
            }
          }
        
          expect{
            post "/user/job_applications", 
                  params
          }.to change(Company, :count).by(1)
        end
      end
      
      context "and the job's Company does exist" do
        before do
          Company.create(name: 'defaultco')
        end
        it 'references the existing Company' do
          params = {
            job_application: {
              applicant_id: user.id,
              job_attributes: {
                title: 'default job',
                company_attributes: {
                  name: 'defaultco'
                }
              }
            }
          }
        
          expect{
            post "/user/job_applications", 
                  params
          }.to_not change(Company, :count)
        end
      end
    end
  
    context 'when the associated Job does exist' do
      before do
        job = Job.new(title: 'job_title')
        job.build_company(name: 'defaultco')
        job.save
      end
      
      it "does not create a new Job" do
        expect{
          post "/user/job_applications",
            job_application: {
              applicant_id: user.id,
              job_attributes: {
                title: 'job_title',
                company_attributes: {
                  name: 'defaultco'
                }
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
              company_attributes: {
                name: 'defaultco'
              }
            }
          }

        app = JobApplication.find_by(applicant: user)
        job = Job.find_by_title_and_company_name(
          'job_title', 
          'defaultco'
        )
        expect(app.job).to eq job
      end
    end
  end
end