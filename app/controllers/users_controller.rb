class UsersController < ApplicationController
  before_action :user_params, only: [:create, :edit, :update]

  def new
    @user = User.new
    # @heights = (56..112).to_a.map { |inch| { id: inch.to_s, name: (inch/12).floor.to_s+'\''+(inch%12).to_s } }
    @heights = (48..100).to_a.map { |inch| (inch/12).floor.to_s+'\''+(inch%12).to_s }
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password_digest, :password, :password_confirmation, :height, :weight, :age)
  end
end
