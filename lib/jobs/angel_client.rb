require 'net/http'
require 'uri'

module Jobs
  class AngelClient
    def get_jobs(per_page=50)
      uri_str = "https://api.angel.co/1/jobs?" +
        "per_page=#{per_page}&" +
        "access_token=#{angellist_token}"
        
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
    
    def angellist_token
      ENV['angellist_token']
    end
  end
end