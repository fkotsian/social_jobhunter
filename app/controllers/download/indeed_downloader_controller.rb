require_relative '../../../lib/download/indeed_client'
require_relative '../../../lib/download/job_downloader'

module Download
  class IndeedDownloaderController < ApplicationController
    def download_development
      client = Download::IndeedClient.new('software')
      downloader = Download::JobDownloader.new(client)
      downloader.delay.download_jobs
      flash[:success] = "Downloading scheduled!"
      redirect_to all_jobs_url
    end
  
    def download_nursing
      client = Download::IndeedClient.new('nursing')
      downloader = Download::JobDownloader.new(client)
      downloader.delay.download_jobs
      flash[:success] = "Downloading scheduled!"
      redirect_to all_jobs_url
    end
  
    def download_marketing
      client = Download::IndeedClient.new('marketing')
      downloader = Download::JobDownloader.new(client)
      downloader.delay.download_jobs
      flash[:success] = "Downloading scheduled!"
      redirect_to all_jobs_url
    end
  end
end