class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]+\Z/
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  validates :password, length: { in: 8..12 }, on: :create
  validates :height, presence: true
  validates :weight, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 13, less_than_or_equal_to: 120}

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :workouts
  has_many :exercise_workouts, through: :workouts
  has_many :memberships
  has_many :gyms, through: :memberships
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end


  def allexercises
    self.workouts.map do |workout|
      workout.exercises
    end.flatten
  end

  def totalexercises
    allexercises.count
  end

  def cardiocount
    x =  self.allexercises.select do |exercise|
      exercise.category == "cardio"
    end
    x.count
  end

  def strengthcount
    y = self.allexercises.select do |exercise|
      exercise.category == "strength"
    end
    y.count
  end

  def cardio_by_percentage
    x = ((self.cardiocount.to_f) / (self.totalexercises.to_f))*100
    x.to_i
  end

  def strength_by_percentage
    y = ((self.strengthcount.to_f) / (self.totalexercises.to_f))*100
    y.to_i
  end

  def favouritexercise
    m = self.allexercises.group_by do |e|
      e
    end
    m.values.max_by(&:size).first
  end

  def friend_workouts
    @user.friends.collect do |friend|
       friend.workouts
     end
   end

## array of all ex workouts with duration
   def total_time_exercise_workouts
     self.exercise_workouts.select do |ex|
       ex.duration
     end
   end

## total duration from all exercise workouts
   def total
     count = 0
     self.total_time_exercise_workouts.each do |ex|
       count += ex.duration
     end
     count
   end

##total workouts
   def total_workouts
     self.workouts.count
   end

   def avg_duration
     self.total / self.total_workouts
   end






end
