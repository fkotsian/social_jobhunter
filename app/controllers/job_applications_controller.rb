class JobApplicationsController < ApplicationController
  def index
    @applications = JobApplication  .where(applicant: current_user)
  end

  def new
    @job = Job.new
    @job_application = JobApplication.new
  end

  def create
    company_name = params[:job][:company_name]
    job_title    = params[:job][:title]
    @company = Company.find_or_create_by_name(company_name)
    @job = @company.jobs.find_or_create_by_title_and_status(job_params, "Open") #may want to mod this to be by_url (need to require URL at DB and model level)
    @job_application = @job.applications.new(applicant: current_user)
    
    if @job_application.save
      flash[:success] = "Congratulations on your new application!"
      redirect_to user_feed
    else
      flash[:error] = "Error: " + @job_application.errors.full_messages
      redirect :back
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end
  
  private
  def job_params
    params.require(:job_application).require(:job)
      .permit(:title, :category, :url, :salary_bottom, :salary_top)
  end
  
  def application_params
  end
end
