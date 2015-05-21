# == Schema Information
#
# Table name: job_applications
#
#  id           :integer          not null, primary key
#  job_id       :integer          not null
#  applicant_id :integer          not null
#  status       :string(255)      default("Applied")
#  created_at   :datetime
#  updated_at   :datetime
#  note         :string(255)
#

class JobApplication < ActiveRecord::Base
  belongs_to :job
  belongs_to :applicant, 
              class_name: 'User', 
              foreign_key: :applicant_id, 
              primary_key: :id
  has_one :job_category, 
           through: :job, 
           source: :job_category
           
  accepts_nested_attributes_for :job

  validates :job, :applicant, :status, presence: true

  def self.statuses
    %W[Applied 
      Screened 
      #{"Interviewed On-Site"} 
      Rejected 
      #{"Offered Position"} 
      #{"Rejected Offer"} 
      #{"Accepted Offer"}
    ]
  end
end