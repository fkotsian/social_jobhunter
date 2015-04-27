require_relative '../../lib/jobs/indeed_client'
require_relative '../../lib/jobs/angel_client'
require_relative '../../lib/jobs/job_downloader'
require_relative '../helpers/vcr_helpers'
require 'spec_helper'

module Jobs
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
    end
  
    context 'from Indeed' do
      it 'creates a job in the database for each job downloaded' do
        VCR.use_cassette('indeed_jobs') do
          client = IndeedClient.new
          downloader = JobDownloader.new(client)
          downloader.download_jobs
          expect(Job.count).to eq 25
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