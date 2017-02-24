class WorkersController < ApplicationController
  before_action :authenticate_worker!, only: [:show]
  def show
    @worker = current_worker
  end

  def new
    @worker = Worker.new
    # current_worker refers to a worker account currently logged in. current_user refers to a user account currently logged in.
    if current_worker
      redirect_to worker_path(current_worker)
      flash[:notice] = "You're already logged into a worker account!"
    end
  end

end
