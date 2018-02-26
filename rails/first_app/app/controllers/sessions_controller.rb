class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      if user.activated?
        log_in(user)
        params[:sessions][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account is not activated"
        message += "Check your email for activation link"
        flash.now[:danger] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    if logged_in?
      log_out
      current_user = nil
    end
    redirect_to root_url
  end
end
