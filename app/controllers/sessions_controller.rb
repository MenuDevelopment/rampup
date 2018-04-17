class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:errors] = "Username/password combination is incorrect."
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id

    redirect_to login_path
  end

end
