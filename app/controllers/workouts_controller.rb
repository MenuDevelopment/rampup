class WorkoutsController < ApplicationController

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
    @workout = Workout.find(params[:id])
    @exercises = Exercise.all
    @e_ws = @workout.exercise_workouts
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
