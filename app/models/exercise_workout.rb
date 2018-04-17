class ExerciseWorkout < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout, optional: true 


end
