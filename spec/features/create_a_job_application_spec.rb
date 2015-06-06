require 'spec_helper'
require 'capybara/rails'

describe 'recording a job application', type: :feature do
  before do
    User.create(email: 'user@example.com', password: 'abcd1234')
    sign_in
  end
  
  it 'Creates a job, company, and job_application' do
    submit_application_for
    expect(page).to have_content 'Congratulations!'
    expect(JobApplication.count).to eq 1
    expect(Job.count).to eq 1
    expect(Company.count).to eq 1
  end
  
  it 'populates the job listings page' do
    submit_application_for
    visit '/jobs'
    expect(page).to have_content 'Real Job'
  end
  
  def submit_application_for(company_name: 'RealCo', 
                             job_title: 'Real Job', 
                             job_url: 'http://www.realjob.co')
    visit '/user/applications'
    within('#app-form') do
      fill_in 'job_application_job_attributes_company_attributes_name', 
        with: company_name
      fill_in 'job_application_job_attributes_title', 
        with: job_title
      fill_in 'job_application_job_attributes_url', 
        with: job_url
    end
    click_button 'Add App'
  end
  
  def sign_in
    visit '/login'
    within '.new_user' do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'abcd1234'
    end
    click_button 'Sign in'
  end
  
end