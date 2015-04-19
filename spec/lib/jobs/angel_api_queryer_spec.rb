require 'spec_helper'
require_relative '../../../lib/jobs/angel_api_queryer'

module Jobs
  describe AngelApiQueryer do
    context 'getting jobs' do
      it 'talks to the client' do
        client = double('angel client')
        queryer = AngelApiQueryer.new(client)
        empty_jobs = { jobs: [] }
        expect(client).to receive(:get_jobs).with(50).and_return(empty_jobs)
        queryer.get_jobs
      end
    end

    context 'downloading jobs' do
      it 'creates a database entry for each job downloaded' do
        client = double('angel client')
        queryer = AngelApiQueryer.new(client)
        jobs = {
          jobs: [
            {
              title: 'job1',
              salary_min: 75000,
              salary_max: 80000,
              angellist_url: 'job1.com',
              startup: {},
            },
            {
              title: 'job2',
              salary_min: 60000,
              salary_max: 70000,
              angellist_url: 'job2.com',
              startup: {},
            }
          ]
        }
        allow(client).to receive(:get_jobs).and_return jobs
        expect(Job).to receive(:create).twice
        queryer.download_jobs
      end
    end
  end
end