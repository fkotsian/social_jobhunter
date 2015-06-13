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

describe Job do  
  context "new Job" do
    it "has a status of 'Open'"
  end

  context "closed Job" do
    it "has a status of 'Closed'"
  end
  
  it 'finds Jobs by title and company name' do
    3.times { FactoryGirl.create(:job) }
    job = Job.new(title: 'job_title')
    job.build_company(name: 'defaultco')
    job.save
    
    expect(
      Job.find_by_title_and_company_name(
      'job_title',
      'defaultco')
    ).to eq job
  end
end