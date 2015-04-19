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
          expect(Job).to receive(:create).exactly(50).times
          downloader.download_jobs
        end
      end
    end
  
    context 'from Indeed' do
      it 'creates a job in the database for each job downloaded' do
        VCR.use_cassette('indeed_jobs') do
          client = IndeedClient.new
          downloader = JobDownloader.new(client)
          expect(Job).to receive(:create).exactly(25).times
          downloader.download_jobs
        end
      end
    end
  end
end