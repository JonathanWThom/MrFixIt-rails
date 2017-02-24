class RegistrationsController < Devise::RegistrationsController

  def new
    @worker = Worker.new
    # current_worker refers to a worker account currently logged in. current_user refers to a user account currently logged in.
    if worker_signed_in?
      redirect_to worker_path(current_worker)

      # not working correctly
      flash[:notice] = "You're already logged into a worker account!"
    end

    if user_signed_in?
      sign_out :current_user
      flash[:notice] = "You have been signed out of your user account."
    end
  end

end
