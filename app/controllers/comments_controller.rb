class CommentsController < ApplicationController
  before_action :require_logged_in, except: :index
  before_action :find_workout
  before_action :set_comment, only: :destroy
  before_action :require_self_or_friendship, except: [:index, :destroy]


  def index
    @comments = @workout.comments.order(created_at: :desc)
  end

  def new
    @comment = @workout.comments.new
  end

  def create
    @comment = @workout.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @workout
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_workout_comment_path
    end
  end

  def destroy
    if @comment
      return head(:forbidden) unless @comment.user == current_user || @workout.user == current_user
      @comment.destroy
      redirect_to @workout
    end
  end

  private

  def require_self_or_friendship
    user = @workout.user
    return head(:forbidden) unless user == current_user || current_user.friends.include?(user)
  end

  def find_workout
    @workout = Workout.find(params[:workout_id])
  end

  def set_comment
    @comment = Comment.find(params[:id]) if params[:id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end


end
