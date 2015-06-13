require_relative '../jobs/job_factory'

module Download
  class JobDownloader
    def initialize(client)
      @client = client
    end
    
    def get_jobs
      client.get_jobs
    end
    
    def download_jobs
      factory = Jobs::JobFactory.new
      jobs = get_jobs
      
      jobs.each do |j_params|         
        job = factory.produce(j_params)

        # j = Job.matching_record_for(j_params)
        # j.update_attributes(j_params)
      end
    end
    # handle_asynchronously :download_jobs
        
    private
    
    attr_reader :client
  end
end