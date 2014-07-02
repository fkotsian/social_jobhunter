class JobCategory < ActiveRecord::Base
  belongs_to :job
  validates :name, presence: true
  
  attr_reader :name
end
