class CommentsController < ApplicationController
  before_action :require_logged_in, except: [:index]
  before_action :require_self_or_friendship, except [:index]
  before_action :find_article!

  def index
    @comments = @workout.comments.order(created_at: :desc)
  end

  def new


  end

  def create
    @comment = @workout.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @comment
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_workout_comment_path
    end
  end

  private

  def require_self_or_friendship
    user = @workout.user
    return head(:forbidden) unless user == current_user || current_user.friends.include?(user)
  end

  def find_article!
    @workout = Workout.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end


end