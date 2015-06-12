require_relative '../../../lib/download/indeed_client'
require_relative '../../helpers/vcr_helpers'
require 'spec_helper'

module Download
  describe IndeedClient do
    it 'queries the Indeed Feed API' do
      VCR.use_cassette('indeed_jobs') do
        client = IndeedClient.new
        resp = client.query_for_jobs
        expect(resp).to match /"results" :/
      end
    end
    
    it 'parses the returned content' do
      VCR.use_cassette('indeed_jobs') do
        client = IndeedClient.new
        jobs = client.get_jobs
        
        expect(jobs).to be_a Array
        expect(jobs[0]).to be_a Hash
        expect(jobs[0]).to have_key :title
        expect(jobs.length).to eq 25
      end
    end
  end
end