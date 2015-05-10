# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  company_id      :integer          not null
#  job_category_id :integer
#  url             :string(255)
#  salary_bottom   :integer
#  salary_top      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  status          :string(255)      default("Open")
#

class Job < ActiveRecord::Base
  belongs_to :company 
  belongs_to :job_category, 
              class_name: "JobCategory", 
              foreign_key: :job_category_id
  has_many :applications, 
            class_name: 'JobApplication'
  has_many :applicants, 
            through: :applications, 
            source: :applicant

  validates :title, presence: true
  validates :company, presence: true
  validates :url, uniqueness: true, allow_nil: true
  
  attr_reader :description
  
  def self.matching_record_for(attrs)
    job_title = attrs['title']
    job_company = attrs['company']
        
    match = where(title: job_title, company_id: job_company.id)
    match.first_or_initialize(attrs)
  end
end