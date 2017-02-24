class JobsController < ApplicationController
  ## authenticate user to create new jobs
  before_action :authenticate_user!, only: [:new, :create]

  ## authenticate worker to select, work on, complete a job
  before_action :authenticate_worker!, only: [:update, :mark_complete, :currently_working]

  expose :unclaimed_jobs, ->{ Job.where(pending: false).where(complete: false) }
  expose :processing_jobs, ->{ Job.where(pending: true).where(current: true).where(complete: false) }
  expose :claimed_jobs, ->{ Job.where(pending: true).where(current: false).where(complete: false) }
  expose :complete_jobs, ->{ Job.where(complete: true) }
  expose :job

  def index
  end

  def new
  end

  def show
  end

  def create
    if job.save
      redirect_to jobs_path
    else
      flash[:notice] = "Something went wrong!"
      render :new
    end
  end

  def update
    if job.update(pending: true, worker_id: current_worker.id)
      respond_to do |format|
        format.html { redirect_to worker_path(current_worker) }
        format.js
      end
    end
  end

  def mark_complete
    if job.update(complete: true, pending: false, current: false)
      respond_to do |format|
        format.html { redirect_to worker_path(current_worker) }
        format.js
      end
    end
  end

  def currently_working
    if job.update(current: true)
      respond_to do |format|
        format.html { redirect_to worker_path(current_worker) }
        format.js
      end
    end
  end

private

  def job_params
    params.require(:job).permit(:title, :description)
  end

end
