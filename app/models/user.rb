class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :exercise_workouts
  has_many :workouts, through: :exercise_workouts
  has_many :memberships
  has_many :gyms, through: :memberships
end
