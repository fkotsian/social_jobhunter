require_relative '../../../lib/download/angel_client'
require_relative '../../helpers/vcr_helpers'
require 'spec_helper'

module Download
  describe AngelClient do
    it 'queries the angellist Jobs API' do
      client = AngelClient.new
      resp = client.query_for_jobs
      expect(resp).to match /"jobs\":/
    end
    
    it 'parses the returned content' do
      VCR.use_cassette('angel_jobs') do
        client = AngelClient.new
        jobs = client.get_jobs
        
        expect(jobs).to be_a Array
        expect(jobs[0]).to be_a Hash
        expect(jobs[0]).to have_key :title
        expect(jobs.length).to eq 50
      end
    end    
  end
end