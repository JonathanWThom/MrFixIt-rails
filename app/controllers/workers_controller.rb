class WorkersController < ApplicationController
  before_action :authenticate_worker!, only: [:show]

  def show
    @worker = current_worker
    @claimed_jobs = @worker.jobs.where(pending: true, complete: false, current: false)
    @processing_jobs = @worker.jobs.where(pending: true, complete: false, current: true)
    @completed_jobs = @worker.jobs.where(complete: true)
  end
end
