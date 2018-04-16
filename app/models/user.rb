class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]+\Z/
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  validates :password, length: { in: 8..12 }
  validates :height, presence: true
  validates :weight, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 13, less_than_or_equal_to: 120}

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :exercise_workouts
  has_many :workouts, through: :exercise_workouts
  has_many :memberships
  has_many :gyms, through: :memberships

  has_secure_password
end
