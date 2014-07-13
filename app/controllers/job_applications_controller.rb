class JobApplicationsController < ApplicationController
  before_action :authenticate_user!, except: [:all_apps]
  
  def index
    @job_applications = JobApplication.where(applicant: current_user)
  end

  def new
    @job = Job.new
    @job_application = JobApplication.new
    @categories = JobCategory.all
  end

  def create
    @company = attempt_company
    @job =     attempt_job
    
    @job_application = @job.applications.new(applicant_id: current_user.id)

    if @job_application.save
      apps_today = JobApplication.where("created_at > ?", Date.today.to_time(:utc)).count
      flash[:success] = "Congratulations! You have applied to #{apps_today} jobs today!"
      redirect_to my_applications_path
    else
      flash[:error] = "Error: " + @job_application.errors.full_messages.to_s
      redirect_to :back
    end
  end

  def show
  end

  def edit
  end

  def update
    @job_application = JobApplication.find(params[:id])
    if @job_application.try(:update_attributes, application_params)
      redirect_to my_applications_path
    else
      flash[:error] = @job_application.errors.full_messages.to_s
      redirect_to my_applications_path
    end
  end

  def delete
  end
  
  def all_apps
  end
  
  private
  def application_params
    params.require(:job_application).permit(:status, :note)
  end
  
  def company_params
    params.require(:company).permit(:name)
  end
  
  def job_params
    params.require(:job).permit(:title, :category_id, :url, :salary_bottom, :salary_top)
  end
  
  def attempt_company
    co = Company.find_or_create_by(company_params)
    unless co
      flash[:error] = "Error: " + co.errors.full_messages.to_s
      redirect_to root_path
    end
    co
  end
  
  def attempt_job #(job_title, job_status)
    job = @company.jobs.find_or_create_by(job_params)
    #may want to mod this to be by_url (need to require URL at DB and model level)
    unless job
      flash[:error] = "Error: " + job.errors.full_messages.to_s
      redirect_to root_path
    end
    job
  end
end
