require 'spec_helper'
require_relative '../../../lib/jobs/job_downloader'

module Jobs
  describe JobDownloader do
    context 'getting jobs' do
      it 'talks to the client' do
        client = double('any client')
        downloader = JobDownloader.new(client)
        empty_jobs = { jobs: [] }
        expect(client).to receive(:get_jobs).and_return(empty_jobs)
        downloader.get_jobs
      end
    end

    context 'downloading jobs' do
      it 'creates a database entry for each job downloaded' do
        client = double('any client')
        downloader = JobDownloader.new(client)
        jobs = [
          {
            title: 'job1',
            salary_bottom: 75000,
            salary_top: 80000,
            url: 'job1.com',
            company: {},
          },
          {
            title: 'job2',
            salary_bottom: 60000,
            salary_top: 70000,
            url: 'job2.com',
            company: {},
          }
        ]
        allow(client).to receive(:get_jobs).and_return jobs
        expect(Job).to receive(:create).twice
        downloader.download_jobs
      end
    end
  end
end