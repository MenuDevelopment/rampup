class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :show, :update, :delete]
  before_action :user_params, only: [:create, :update]
  before_action :require_logged_in, except: [:new, :create]

  def index
    @users = User.all
  end

  def home
    @user = current_user
    redirect_to @user
  end

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
      redirect_to signup_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @heights = (48..100).to_a.map { |inch| (inch/12).floor.to_s+'\''+(inch%12).to_s }

    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    @user.first_name = user_params[:first_name]

    if @user.valid?
      @user.save
      redirect_to root_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  def show
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password_digest, :password, :password_confirmation, :height, :weight, :age)
  end
end
