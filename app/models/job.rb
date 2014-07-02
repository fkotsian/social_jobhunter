class Job < ActiveRecord::Base
  belongs_to :company
  has_one :job_category
  
  validates :title, presence: true
  validates :company, presence: true
  validates :url, uniqueness: true, allow_nil: true
end
