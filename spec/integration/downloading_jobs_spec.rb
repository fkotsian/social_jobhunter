require_relative '../../lib/download/indeed_client'
require_relative '../../lib/download/angel_client'
require_relative '../../lib/download/job_downloader'
require_relative '../helpers/vcr_helpers'
require 'spec_helper'

module Download
  describe 'downloading jobs' do
    context 'from Angellist' do      
      it 'creates a job in the database for each job downloaded' do
        VCR.use_cassette('angel_jobs') do
          client = AngelClient.new
          downloader = JobDownloader.new(client)
          downloader.download_jobs
          expect(Job.count).to eq 50
        end
      end
      
      it 'creates associated Companies in the database for each Job created' do
        VCR.use_cassette('angel_jobs') do
          client = AngelClient.new
          downloader = JobDownloader.new(client)
          downloader.download_jobs
          expect(Company.count).to eq 39
        end
      end
    end
  
    context 'from Indeed' do
      # NOTE: This is 22 because there are 3 duplicate jobs in the Indeed sample data. Filed #96942282 to consider.
      it 'creates a job in the database for each job downloaded' do
        VCR.use_cassette('indeed_jobs/development') do
          client = IndeedClient.new
          downloader = JobDownloader.new(client)
          downloader.download_jobs
          expect(Job.count).to eq 22
        end
      end
      
      it 'creates associated Companies in the database for each Job created' do
        VCR.use_cassette('indeed_jobs/development') do
          client = IndeedClient.new
          downloader = JobDownloader.new(client)
          downloader.download_jobs
          expect(Company.count).to eq 16
        end
      end
    end
    
    context 'when downloading a job for a second time' do
      it 'updates the existing record instead of creating a new Job' do
        VCR.use_cassette('angel_jobs', allow_playback_repeats: true) do
          client = AngelClient.new
          downloader = JobDownloader.new(client)
          2.times { downloader.download_jobs }
          expect(Job.count).to eq 50
        end    
      end
    end
  end
end