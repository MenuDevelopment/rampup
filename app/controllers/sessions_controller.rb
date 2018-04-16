class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    user = user.try(:authenticate, params[:user][:password])

    if user
      session[:user_id] = user.id
      @user = user
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to root_path
    end
    # return redirect_to(controller: 'sessions', action: 'new') unless user
    # redirect_to controller: 'application', action: 'index'
  end

  def destroy
    session.delete :user_id

    redirect_to root_path
  end

end
