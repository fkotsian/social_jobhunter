require_relative '../../lib/download/angel_client'
require_relative '../../lib/download/job_downloader'
require_relative '../helpers/vcr_helpers'
require 'spec_helper'

describe 'downloading jobs to populate the database', type: :feature do
  context 'from Angellist' do
    it 'queues downloading the jobs' do
      VCR.use_cassette('angel_jobs') do
        expect { 
          visit download_from_angellist_url 
        }.to change(Delayed::Job, :count).by(1)
      end
    end
    
    it 'downloads jobs' do
      VCR.use_cassette('angel_jobs') do
        visit download_from_angellist_url
        expect { 
          Delayed::Worker.new.work_off
        }.to change(Job, :count).by(50)
      end
    end
  end
  
  context 'from Indeed' do
    context 'development jobs' do
      it 'queues downloading the jobs' do
        VCR.use_cassette('indeed_jobs/development') do
          expect { 
            visit download_from_indeed_development_url
          }.to change(Delayed::Job, :count).by(1)
        end
      end
    
      it 'downloads jobs' do
        VCR.use_cassette('indeed_jobs/development') do
          visit download_from_indeed_development_url
          expect { 
            Delayed::Worker.new.work_off
          }.to change(Job, :count).by(25)
        end
      end
    end
    
   context 'nursing jobs' do
     it 'queues downloading the jobs' do
       VCR.use_cassette('indeed_jobs/nursing') do
         expect { 
           visit download_from_indeed_nursing_url
         }.to change(Delayed::Job, :count).by(1)
       end
     end
    
     it 'downloads jobs' do
       VCR.use_cassette('indeed_jobs/nursing') do
         visit download_from_indeed_nursing_url
         expect { 
           Delayed::Worker.new.work_off
         }.to change(Job, :count).by(25)
       end
     end
   end
    
    context 'marketing jobs' do
      it 'queues downloading the jobs' do
        VCR.use_cassette('indeed_jobs/marketing') do
          expect { 
            visit download_from_indeed_marketing_url
          }.to change(Delayed::Job, :count).by(1)
        end
      end
    
      it 'downloads jobs' do
        VCR.use_cassette('indeed_jobs/marketing') do
          visit download_from_indeed_marketing_url
          expect { 
            Delayed::Worker.new.work_off
          }.to change(Job, :count).by(25)
        end
      end
    end
  end
end
