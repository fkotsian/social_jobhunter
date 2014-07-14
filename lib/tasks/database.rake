require 'open-uri'

namespace :fetch do
  desc "update job applications and store them in the database"
  task jobs: :environment do
    number_of_pages = 234

    jobs = []
    234.times do |num|
      jobs.push(JSON.load(open("https://api.angel.co/1/jobs?page=#{num+1}")))

      def parse_company_size(company_size_string)
        return company_size_string if company_size_string.class != "String"
        company_size_string.split("-").map(&:to_i)
      end

      operations = JobCategory.where(name: "operations")[0]
      product_management = JobCategory.where(name: "product_management")[0]
      marketing = JobCategory.where(name: "marketing")[0]
      development = JobCategory.where(name: "development")[0]
      sales = JobCategory.where(name: "sales")[0]
      design = JobCategory.where(name: "design")[0]
      finance = JobCategory.where( name: "finance")[0]
      human_resources = JobCategory.where(name: "human_resources")[0]
      not_avaliable = JobCategory.where(name: "not_avaliable")[0]



      #refactor this method to make it cleaner
      jobs.each do |job_details|

        company_size_min, company_size_max =
          parse_company_size(job_details["company_size"])

        job_details['jobs'].each do |job|
          company_name = job["startup"]["name"]
          company_url = job["startup"]["company_url"]
          company_desc = job["startup"]["product_desc"]
          company = Company.create(
            name: company_name,
            company_url: company_url,
            description: company_desc
          )

          job_url = job["startup"]["angellist_url"]
          salary_min = job["salary_min"]
          salary_max = job["salary_max"]
          title =  job["title"]
          created_at = job["created_at"]
          updated_at = job["updated_at"]
          role_tags = []
          job["tags"].each do |tag|
            role_tags.push(tag["name"]) if tag['tag_type'] == "RoleTag"
          end
          case role_tags[0]
          when "operation"
            p "I m returning operations"
            category = operations
          when "sales"
            p "I m returning sales"
            category = sales
          when "marketing"
            p "I m returning marketing"
            category = marketing
          when "developer"
            p "I m returning development"
            category = development
          when "finance"
            p "I m returning finance"
            category = finance
          when "human_resources"
            p "I m returning human resources"
            category = human_resources
          when "design"
            p "I m returning design"
            category = design
          end
          # category = match_category(role_tags[0])
          p category
          category = not_avaliable if category.nil?
          p category.id
          job = Job.create(
            title: title,
            salary_bottom: salary_min,
            salary_top: salary_max,
            job_category_id: category.id,
            company_id: company.id
          )
          p "I am working"
        end
      end
    end
  end
end
