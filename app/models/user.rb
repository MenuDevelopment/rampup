class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :workouts
  has_many :exercise_workouts, through: :workouts
  has_many :memberships
  has_many :gyms, through: :memberships
end
