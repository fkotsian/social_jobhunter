class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :url, uniqueness: true
  
  has_many :jobs
  # has_many :applications, through: :jobs, source: :job_applications
end
