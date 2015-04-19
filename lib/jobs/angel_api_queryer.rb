require_relative 'angel_client'

module Jobs
  class AngelApiQueryer
    def initialize(client)
      @angel_client = client
    end
    
    def get_jobs
      parse(angel_client.get_jobs(50))
    end
    
    def download_jobs
      jobs = get_jobs
      jobs.each {|j| Job.create(j)}
    end
    
    private
    
    def parse(jobs_hash)
      jobs = jobs_hash[:jobs]

      jobs.map do |job|
        job_attrs = {}
        co_attrs = {}

#         co = job[:startup]
#         co_attrs[:name] = co[:name]
#         co_attrs[:url] = co[:company_url]
#         co_attrs[:logo_url] = co[:logo_url]
#         co_attrs[:thumb_url] = co[:thumb_url]
#         co_attrs[:description] = co[:product_desc]
#
#         job_attrs[:company] = co_attrs

        job_tags = job.fetch(:tags, {})
        location = job_tags.select {|t| t[:tag_type] == "LocationTag"}[:display_name]
        category = job_tags.select {|t| t[:tag_type] == "RoleTag"}[:display_name]

        job_attrs[:job_category] = job_categories.index(category)
        job_attrs[:location] = location
        job_attrs[:title] = job[:title]
        job_attrs[:url] = job[:angellist_url]
        job_attrs[:description] = job[:description]
        job_attrs[:salary_bottom] = job[:salary_min]
        job_attrs[:salary_top] = job[:salary_max]

        # job_attrs[:currency_code] = job[:currency_code]
        job_attrs[:last_updated] = job[:updated_at]

        job_attrs
      end
      
      #posname
      #coname
      #company url
      #company_logo
      #description
      #post date
      # salary min
      # salary max
      #job URL
      # job type/category
      
    end
    
    def job_keys
      %w[angel_id title description updated_at salary_min salary_max currency_code job_type angellist_url]
    end
    
    def company_keys
      %w[angel_id name company_url angellist_url logo_url thumb_url product_desc]
    end
    
    def job_categories
      JobCategory.names
    end
       
    attr_reader :angel_client
  end
end