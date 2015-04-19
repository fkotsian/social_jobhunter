# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  company_id      :integer          not null
#  job_category_id :integer
#  url             :string(255)
#  salary_bottom   :integer
#  salary_top      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  status          :string(255)      default("Open")
#

require 'spec_helper'
require_relative '../../app/models/job'

module Jobs
  describe Job do
    it "has a valid factory"
    it "belongs to a company"
    it "has one category"
    it "has a title"
    it "may have a URL"
    it "may have a salary bottom"
    it "may have a salary top"
  
    context "new Job" do
      it "has a status of 'Open'"
    end
  
    context "closed Job" do
      it "has a status of 'Closed'"
    end
  end
end