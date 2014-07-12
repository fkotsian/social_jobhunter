class Job < ActiveRecord::Base
  belongs_to :company
  belongs_to :job_category, class_name: "JobCategory", foreign_key: :job_category_id
  has_many :applications, class_name: 'JobApplication'
  
  validates :title, presence: true
  validates :company, presence: true
  validates :url, uniqueness: true, allow_nil: true
end
