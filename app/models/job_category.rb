class JobCategory < ActiveRecord::Base
  has_many :jobs
  validates :name, presence: true
  
  attr_reader :name
end
