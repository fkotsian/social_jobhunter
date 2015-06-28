require 'net/http'
require 'uri'
require 'figaro'

module Download
  class AngelClient
    def get_jobs
      parse(query_for_jobs)
    end
    
    def query_for_jobs(per_page=50)
      uri_str = "https://api.angel.co/1/jobs?" +
        "per_page=#{per_page}&" +
        "access_token=#{api_token}"
      resp = make_req(uri_str)
      resp.body
    end
    
    private
    
    def get_token
      uri_str = "https://angel.co/api/oauth/token?" + 
        "client_id=#{ENV['angellist_client_id']}&" + 
        "client_secret=#{ENV['angellist_client_secret']}&" +
        "code=#{get_code}"
      resp = make_req(uri_str)
      @token = resp.body
    end
    
    def get_code
      uri_str = "https://angel.co/api/oauth/token?" + 
        "client_id=#{ENV['angellist_client_id']}&" + 
        "response_type=code"
        
      resp = make_req(uri_str)
      @code = resp.body
    end
    
    def make_req(uri_str)
      uri = URI.parse(uri_str)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      req = Net::HTTP::Get.new(uri.request_uri)
      http.request(req)
    end
    
    def parse(resp)
      jobs_hash = JSON.parse(resp)
      jobs = jobs_hash.fetch('jobs', {})

      jobs.map do |job|
        job_attrs = {}
        co_attrs = {}
        loc_attrs = {}
        category_attrs = {}

        startup = job['startup']
        co_attrs[:name] = startup['name']
        co_attrs[:url] = startup['company_url']
#         co_attrs[:logo_url] = startup['logo_url']
#         co_attrs[:thumb_url] = startup['thumb_url']
        co_attrs[:description] = startup['product_desc']

        job_tags = job.fetch('tags', {})
        location_tag = job_tags.detect {|t| t['tag_type'] == "LocationTag"}['display_name']
        category_tag = job_category(job_tags)

        loc_attrs[:city] = location_tag.titleize
        category_attrs[:name] = category_tag.titleize
        
        job_attrs[:title] = job['title']
        job_attrs[:url] = job['angellist_url']
        job_attrs[:description] = job['description']
        job_attrs[:salary_bottom] = job['salary_min']
        job_attrs[:salary_top] = job['salary_max']

        # job_attrs[:currency_code] = job[:currency_code]
        job_attrs[:last_updated] = job['updated_at']
        
        job_attrs[:company_attributes] = co_attrs
        job_attrs[:location_attributes] = loc_attrs
        job_attrs[:job_category_attributes] = category_attrs
        job_attrs
      end
    end
   
    def api_token
      t = ENV['angellist_token']
      t ? t : (raise "Missing #{self.class.name} API token.")
    end
    
    def job_category(job_tags)
      category = job_tags.detect {|t| t['tag_type'] == "RoleTag"}['display_name']
      case category.downcase
      when /.*developer.*/
        'Software Development'
      when /.*software.*/
        'Software Development'
      when /.*ui.*/
        'Design'
      when /.*ux.*/
        'Design'
      when /.*design.*/
        'Design'
      when /.*biz dev.*/
        'Business Development'
      when /.*business development.*/
        'Business Development'
      when /.*sales.*/
        'Sales'
      when /.*nurs.*/
        'Nursing'
      else
        'Unknown'
      end
    end
    
    def job_categories
      JobCategory.names
    end
  end
end