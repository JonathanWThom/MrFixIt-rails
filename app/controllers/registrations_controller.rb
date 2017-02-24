class RegistrationsController < Devise::RegistrationsController

  def new
    @worker = Worker.new

    if user_signed_in?
      sign_out current_user
      flash[:notice] = "You have been signed out of your user account."
    end
  end

end
