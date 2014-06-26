class Job < ActiveRecord::Base
  belongs_to :company
  
  validates :title, presence: true
  validates :company, presence: true
  validates :url, uniqueness: true, allow_nil: true
end
