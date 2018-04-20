class ExercisesController < ApplicationController
  before_action :require_logged_in

def index
  @exercises = Exercise.all
end

def show
  @exercise = Exercise.find(params[:id])
end

end
