module Jobs
  class JobDownloader
    def initialize(client)
      @client = client
    end
    
    def get_jobs
      client.get_jobs
    end
    
    def download_jobs
      jobs = get_jobs
      p jobs.length
      p jobs
      jobs.each {|j| Job.create(j)}
    end
    
    attr_reader :client
  end
end