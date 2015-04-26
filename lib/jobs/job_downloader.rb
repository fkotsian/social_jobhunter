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
      unknown_co = Company.unknown_co
      
      jobs.each do |j_params| 
        j = Job.new(j_params)
        j.company = unknown_co unless j.company
        j.save!
      end
    end
    
    attr_reader :client
  end
end