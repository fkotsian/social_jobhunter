require 'net/http'
require 'json'
require 'uri'

module Jobs
  class IndeedClient
    BASE_URI = 'http://api.indeed.com/ads'
    
    def get_jobs
      parse(query_for_jobs)
    end
    
    def query_for_jobs(query='software', location='san+francisco')
      uri_str = "#{BASE_URI}/apisearch?" +
        "publisher=#{api_token}&" +
        "q=#{query}&" +
        "l=#{location}&" +
        "sort=date&" +
        "jt=fulltime&" +
        "format=json&" +
        "limit=50&" +
        "fromage=1&" + 
        "userip=162.246.145.234&" +
        "useragent=Mozilla/%2F4.0%28Firefox%29&" +
        "v=2"

      resp = make_req(uri_str, false)
      resp.body
    end
    
    private
    
    def parse(resp)
      jobs_hash = JSON.parse(resp)
      jobs = jobs_hash.fetch('results', {})
        
      jobs.map do |job|
        job_attrs = {}
        co_attrs = {}

        # co_attrs[:name] = job[:company]

        # category = 'software'
        # job_attrs[:job_category] = job_categories.index(category)
        
        job_attrs[:location] = job[:formatted_location]
        job_attrs[:title] = job[:jobtitle]
        job_attrs[:url] = job[:url]
        job_attrs[:description] = job[:snippet]
        job_attrs[:salary_bottom] = job[:salary_min]
        job_attrs[:salary_top] = job[:salary_max]

        # job_attrs[:currency_code] = job[:currency_code]
        job_attrs[:last_updated] = job[:date]

        job_attrs
      end
      
      
    end
    
    def make_req(uri_str, use_ssl=true)
      uri = URI.parse(uri_str)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      req = Net::HTTP::Get.new(uri.request_uri)
      http.request(req)
    end
    
    def api_token
      ENV['indeed_publisher_id']
    end
  end
end