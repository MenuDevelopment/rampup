class WorkoutsController < ApplicationController
  before_action :require_logged_in
  before_action :set_workout, only: [:show, :edit, :update]
  before_action :require_self_or_friendship, only: :show

  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new
    @exercises = Exercise.all
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.valid?
      @workout.save
      redirect_to workout_path(@workout)
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to new_workout_path
    end
  end

  def edit
    @exercises = Exercise.all
    @e_ws = @workout.exercise_workouts
  end

  def update
    @workout.update(workout_params)
    if @workout.valid?
      redirect_to @workout
    else
      byebug
      flash[:errors] = @workout.errors.full_messages
      redirect_to edit_workout_path(@workout)
    end
  end


  def show
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def require_self_or_friendship
    user = @workout.user
    return head(:forbidden) unless user == current_user || current_user.friends.include?(user)
  end

  def workout_params
    params.require(:workout).permit(:name, :day,
      user: [],
      exercise_ids: [],
       exercise_workouts_attributes: [
         :duration,
         :reps,
         :distance,
         :weight,
         :id
         ]
       )
  end

end
