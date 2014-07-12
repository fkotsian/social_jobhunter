class CompaniesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @companies = Company.all
  end
  
  def show
  end
  
  def create
  end
  
  def update
  end
  
  def edit
  end
  
  def new
  end
  
  def destroy
  end
  
  private
  def company_params
  end
  
end