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
        company = Company.create!(name: 'fakeco')
        downloader = JobDownloader.new(client)
        jobs = [
          {
            'title' => 'job1',
            'salary_bottom' => 75000,
            'salary_top' => 80000,
            'url' => 'job1.com',
            'company' => company
          },
          {
            'title' => 'job2',
            'salary_bottom' => 60000,
            'salary_top' => 70000,
            'url' => 'job2.com',
            'company' => company
          }
        ]
        allow(client).to receive(:get_jobs).and_return jobs
        downloader.download_jobs
        expect(Job.count).to eq 2
      end
      
      context 'when downloading an already existing job' do
        it 'updates the existing entry instead of creating a new one' do
          client = double('any client')
          company = Company.create!(name: 'fakeco')
          downloader = JobDownloader.new(client)
          jobs = [
            {
              'title' => 'job1',
              'salary_bottom' => 75000,
              'salary_top' => 80000,
              'url' => 'job1.com',
              'company' => company
            },
            {
              'title' => 'job2',
              'salary_bottom' => 60000,
              'salary_top' => 70000,
              'url' => 'job2.com',
              'company' => company
            },
            {
              'title' => 'job2',
              'salary_bottom' => 60000,
              'salary_top' => 70000,
              'url' => 'job2again.com',
              'company' => company
            }
          ]
          allow(client).to receive(:get_jobs).and_return jobs
          downloader.download_jobs
          expect(Job.count).to eq 2   # still has only 2 jobs in table
          expect(Job.find_by(title: 'job2').url).to eq 'job2again.com'
        end
      end
    end
  end
end