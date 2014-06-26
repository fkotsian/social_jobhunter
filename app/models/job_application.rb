class JobApplication < ActiveRecord::Base
  belongs_to :job
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_id, primary_key: :id
  
  validates :job, :user, :status, presence: true
end
