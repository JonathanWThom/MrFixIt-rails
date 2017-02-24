class JobsController < ApplicationController
  ## authenticate user to create new jobs
  before_action :authenticate_user!, only: [:new, :create]

  ## authenticate worker to select a job
  before_action :authenticate_worker!, only: [:update]


  def index
    @unclaimed_jobs = Job.where(pending: false).where(complete: false)
    @processing_jobs = Job.where(pending: true).where(current: true).where(complete: false)
    @claimed_jobs = Job.where(pending: true).where(current: false).where(complete: false)
    @completed_jobs = Job.where(complete: true)
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
      flash[:notice] = "Something went wrong!"
      render :new
    end
  end

  def update
    ## fix?
    @job = Job.find(params[:id])

    if @job.update(pending: true, worker_id: current_worker.id)
      respond_to do |format|
        format.html { redirect_to worker_path(current_worker) }
        format.js
      end
    else
      render :show
      flash[:notice] = "Something went wrong!"
    end
  end

  def mark_complete
    @job = Job.find(params[:job_id])

    if @job.update(complete: true, pending: false)
      respond_to do |format|
        format.html { redirect_to worker_path(current_worker) }
        format.js
      end
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
