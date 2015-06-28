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
#  last_updated    :datetime
#  description     :text
#  location_id     :integer
#

class Job < ActiveRecord::Base
  belongs_to :company 
  belongs_to :job_category
  belongs_to :location
  has_many :applications, 
            class_name: 'JobApplication'
  has_many :applicants, 
            through: :applications, 
            source: :applicant

  validates :title, presence: true
  validates :company, presence: true
  validates :url, uniqueness: true, allow_nil: true
  
  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :job_category
  
  def self.matching_record_for(attrs)
    job_title = attrs['title']
    job_company = attrs['company']
        
    match = where(title: job_title, company_id: job_company.id)
    match.first_or_initialize(attrs)
  end
  
  def self.find_by_title_and_company_name(title, co_name)
    Job.joins(:company).where(
      title: title, 
      companies: {
        name: co_name 
      }
    ).first
  end
end
