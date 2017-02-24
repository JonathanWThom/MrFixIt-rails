class WorkersController < ApplicationController
  before_action :authenticate_worker!, only: [:show]

  def show
    @worker = current_worker
  end
  
end


# need to make sure users signing up to be workers are signed out of their user account first. -Mr. Fix-It
