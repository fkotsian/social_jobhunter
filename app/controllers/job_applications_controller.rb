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
    @company = attempt_company(params[:company][:company_name])
    @job =     attempt_job(params[:job][:title], "Open")
    
    @job_application = @job.applications.new(applicant_id: current_user.id)

    if @job_application.save
      flash[:success] = "Congratulations on your new application!"
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
  end

  def delete
  end
  
  def all_apps
  end
  
  private
  def job_params
    params.require(:job).permit(:title, :category_id, :url, :salary_bottom, :salary_top)
  end
  
  def attempt_company(company_name)
    co = Company.find_or_create_by(name: company_name)
    # co ||= Company.new(name: company_name)
    unless co
      flash[:error] = "Error: " + co.errors.full_messages.to_s
      redirect_to root_path
    end
    co
  end
  
  def attempt_job(job_title, job_status)
    job = @company.jobs.find_or_create_by(title: job_title, status: job_status)
    #may want to mod this to be by_url (need to require URL at DB and model level)
    # job ||= @company.jobs.new(job_params)
    unless job.save
      flash[:error] = "Error: " + job.errors.full_messages.to_s
      redirect_to root_path
    end
    job
  end
  
  def application_params
  end
end
