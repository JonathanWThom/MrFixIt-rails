class JobsController < ApplicationController
  ## authenticate user to create new jobs
  before_action :authenticate_user!, only: [:new, :create]

  ## authenticate worker to select a job
  before_action :authenticate_worker!, only: [:update]


  def index
    @jobs = Job.all
  end

  def new
   @job = Job.new
  end

  def show
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    ## fix?
    @job = Job.find(params[:id])
    if @job.update(pending: true, worker_id: current_worker.id)
      redirect_to worker_path(current_worker)
      flash[:notice] = "You've successfully claimed this job."
    else
      render :show
      flash[:notice] = "Something went wrong!"
    end
  end

private

  def job_params
    params.require(:job).permit(:title, :description)
  end

end
