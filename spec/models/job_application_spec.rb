# == Schema Information
#
# Table name: job_applications
#
#  id           :integer          not null, primary key
#  job_id       :integer          not null
#  applicant_id :integer          not null
#  status       :string(255)      default("Applied")
#  created_at   :datetime
#  updated_at   :datetime
#  note         :string(255)
#

require 'factory_girl'
require 'spec_helper'
require_relative '../../app/models/job_application'

module Jobs
  describe JobApplication do
    context "validations" do
      it "has a valid factory" do
        FactoryGirl.create(:job_application).should be_valid
      end
      it "belongs to a job" do
        app = FactoryGirl.create :job_application
        expect(app.job_id).to be_a Integer
      end
      it "belongs to an applicant" do
        app = FactoryGirl.create :job_application
        expect(app.applicant.id).to be_a Integer
      end
      it "has a status" do
        app = FactoryGirl.create :job_application
        expect(app.status).to eq("Applied")
      end
    end
  end
end