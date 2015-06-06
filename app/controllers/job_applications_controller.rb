class JobApplicationsController < ApplicationController
  before_action :authenticate_user!, except: [:all_apps]
  
  def index
    @job_applications = JobApplication.where(applicant: current_user)
    @job_application = JobApplication.new
    @job_application.build_job.build_company
  end

  def new
    @job_application = JobApplication.new
    @job = @job_application.job.build
    @categories = JobCategory.all
  end

  def create
    @job_application = JobApplication.new(applicant: current_user)
    found_job = Job.find_by(job_params)
    found_co = Company.find_by(company_params)
        
    @job_application.job ||= (found_job || @job_application.build_job(
      job_params
    ))
    @job_application.job.company ||= (found_co || @job_application.job.build_company(
      company_params
    ))
    if @job_application.save
      apps_today = JobApplication.where(
        "created_at > ?",
        Date.today.to_time(:utc)
      ).count
      apps_today = 5
      flash[:success] = "Congratulations! " + 
        "You have applied to #{apps_today} jobs today!"
      redirect_to my_applications_path
    else
      flash[:error] = "Error: " + 
        @job_application.errors.full_messages.to_s
      redirect_to my_applications_path
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
  
  def company_applications
    @job_applications = JobApplication.where(company_id: params[:company_id])
    render :index
  end
  
  def category_applications
    @job_applications = JobApplication.find_by_sql ["
      SELECT ja.*
      FROM job_applications ja JOIN jobs j
      ON ja.job_id = j.id
      WHERE j.job_category_id = ?
    ", params[:category_id]]
    render :index
  end
  
  def area_applications
  end
  
  private
  def job_application_params
    params.require(:job_application)
          .permit(:applicant_id, 
                  :status, 
                  :note, 
                  :id,
                  job_attributes: [
                    :id,
                    :title,
                    company_attributes: [
                      :id,
                      :name
                      ]
                    ]
                  )
  end
  
  def company_params
    params.
      require(:job_application).
      require(:job_attributes).
      require(:company_attributes).
      permit(:name,
             :id
      )
  end
  
  def job_params
    params.
      require(:job_application).
      require(:job_attributes).
      permit(:title, 
             :category_id, 
             :url, 
             :salary_bottom, 
             :salary_top,
             company: [
               :id,
               :name
             ])
  end
  
  def attempt_company
    company = Company.find_or_create_by(company_params)
    unless company
      flash[:error] = "Error: " + company.errors.full_messages.to_s
      redirect_to my_applications_path
    end
    company
  end
  
  def attempt_job
    job = @company.jobs.find_or_create_by(job_params)
    #may want to mod this to be by_url (need to require URL at DB and model level)
    unless job
      flash[:error] = "Error: " + job.errors.full_messages.to_s
      redirect_to my_applications_path
    end
    job
  end
end
