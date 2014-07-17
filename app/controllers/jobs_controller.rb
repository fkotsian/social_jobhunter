class JobsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @jobs = Job.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end
  
  def category_jobs
    @jobs = Job.where(job_category_id: params[:category_id])
    render :index
  end
    
  def company_jobs  
    @jobs = Job.where(company_id: params[:company_id])
    render :index
  end
  
  def area_jobs
  end
  
  private
  def job_params
  end
  
end
