# == Schema Information
#
# Table name: job_categories
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#  display_name :string(255)
#

class JobCategory < ActiveRecord::Base  
  has_many :jobs
  validates :name, uniqueness: true
  
  attr_reader :name
  
  def self.names
    categories = self.all.pluck(:display_name)
  end

end
