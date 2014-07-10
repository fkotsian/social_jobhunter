require 'spec_helper'

describe JobApplicationsController do
  describe "CREATE new application" do
    it "creates a valid job_application" do
      app = JobApplication.create
      get :index
      expect(assigns(:applications)).to eq( [app] )
    end

    it "creates a new Job if one does not exist"
    
    it "does not create a new Job if one does already exist"

  end
end