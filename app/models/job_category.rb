class JobCategory < ActiveRecord::Base
  has_many :jobs
  validates :name, uniqueness: true
  
  attr_reader :name
end
