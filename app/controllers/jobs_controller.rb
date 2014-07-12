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
end
