require 'rufus-scheduler'
require_relative '../../lib/jobs/angel_client'
require_relative '../../lib/jobs/indeed_client'
require_relative '../../lib/jobs/job_downloader'


s = Rufus::Scheduler.singleton
schedulable_clients = [Jobs::AngelClient, Jobs::IndeedClient]

downloaders = schedulable_clients.map do |client_class|
  Jobs::JobDownloader.new(client_class.new)
end

s.cron '0 0 12 * *' do
  downloaders.each do |dler|
    dler.download_jobs
    Rails.logger.info "Downloaded jobs with #{dler.client} at #{Time.now}."
  end
end