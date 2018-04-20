class ExerciseWorkout < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  validates :weight, numericality: { only_float: true, greater_than_or_equal_to: 0}, on: :update, allow_blank: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0}, on: :update, allow_blank: true
  validates :reps, numericality: { only_integer: true, greater_than_or_equal_to: 0}, on: :update, allow_blank: true
  validates :distance, numericality: { only_integer: true, greater_than_or_equal_to: 0}, on: :update, allow_blank: true
end
