class JobApplication < ActiveRecord::Base
  belongs_to :job
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_id, primary_key: :id
  has_one :job_category, through: :job, source: :job_category
  
  validates :job, :applicant, :status, presence: true
end
