class WorkersController < ApplicationController
  before_action :authenticate_worker!, only: [:show]


  expose :processing_jobs, ->{ Job.where(pending: true).where(current: true).where(complete: false) }
  expose :claimed_jobs, ->{ Job.where(pending: true).where(current: false).where(complete: false) }
  expose :complete_jobs, ->{ Job.where(complete: true) }
  expose :job

  def show
    # @worker = current_worker
    # @current_worker_claimed_jobs = Job.where(pending: true, complete: false, current: false)
    # @current_worker_processing_jobs = Job.where(pending: true, complete: false, current: true)
    # @current_workcompleted_jobs = Job.where(complete: true)
  end
end
