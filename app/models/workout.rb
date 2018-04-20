class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercise_workouts
  has_many :exercises, through: :exercise_workouts
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :exercise_workouts, allow_destroy: true

  def sort_exercises
    #method that returns all excerises for this workout, sorted first by category then by name
    #workout.sort_exercises
    self.exercises.sort_by do |exercise|
      [exercise.category, exercise.name]
    end
  end
end


def strength_per_workout
   self.exercises.select do |exercise|
    exercise.category == "strength"
    end
end

def strengthcount_per_workout
  self.strength_per_workout.count
end
