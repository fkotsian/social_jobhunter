require_relative '../../../lib/download/angel_client'
require_relative '../../../lib/download/job_downloader'

module Download
  class AngellistDownloaderController < ApplicationController
    def download
      client = Download::AngelClient.new
      downloader = Download::JobDownloader.new(client)
      downloader.delay.download_jobs
      flash[:success] = "Downloading scheduled!"
      redirect_to all_jobs_url
    end
  end
end