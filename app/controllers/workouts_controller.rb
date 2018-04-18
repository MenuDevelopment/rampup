class WorkoutsController < ApplicationController

  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new
    @exercises = Exercise.all
    @users = User.all
  end

  def create
    params[:workout][:user] = User.find(params[:workout][:user])

    @workout = Workout.create(workout_params)
    if @workout.valid?
      redirect_to edit_workout_path(@workout)
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to new_workout_path
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    @exercises = Exercise.all
  end

  def update
    @workout = Workout.find(params[:id])
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
    @workout = Workout.find(params[:id])
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :day, :user,
       exercise_ids: [:id],
       exercise_workouts_attributes: [
         :duration,
         :reps,
         :distance,
         :weight
         ]
       )
  end

end
