# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  description  :string(255)
#  company_size :integer
#  industry     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  url          :string(255)
#

class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :url, uniqueness: true, allow_nil: true
  has_many :jobs
  # has_many :applications, through: :jobs, source: :job_applications
  
  # before_save :ensure_description!

  def display_description
    if self.description.nil?
      "<em>No description yet given<em>".html_safe
    elsif self.description && self.description.length > 100 
      "#{self.description[0..100]}..."
    else
      self.description
    end
  end
  
  def self.unknown_co
    Company.find_by(name: 'UnknownCo') || self.create!(name: 'UnknownCo', description: "We're not too sure which company this job applies to. Check the URL?")
  end
  
  private
  
  def ensure_description!
    self.description ||= "No description yet given"
  end 
end
