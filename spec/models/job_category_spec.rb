require 'spec_helper'
require_relative '../../app/models/job_category'

describe JobCategory do  
  context "seeding the database" do
    it "creates the preset job categories" do
      expect(JobCategory.names).to match_array [
        'Software Development',
        'Sales',
        'Design',
        'Marketing',
        'Nursing'
      ]
    end
  end
end