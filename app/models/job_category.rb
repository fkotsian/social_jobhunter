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
  
  def self.names
    all.map(&:display_name)
  end
  
  def display_name
    super || name.titleize
  end
  
  def self.unknown_category
    find_by(name: 'Unknown') || create!(name: 'Unknown')
  end
end
