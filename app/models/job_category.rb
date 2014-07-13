class JobCategory < ActiveRecord::Base  
  has_many :jobs
  validates :name, uniqueness: true
  
  attr_reader :name
  
  def self.names
    categories = self.all.pluck(:name)
  end
end
