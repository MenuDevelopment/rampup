# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#sample strength exercises
Exercise.create(name: "Flat Barbell Press", description: "Chest exercise", category: "strength")
Exercise.create(name: "Dumbbell Press", description: "Chest exercise", category: "strength")
Exercise.create(name: "Dips", description: "Chest and Tris exercise", category: "strength")
Exercise.create(name: "Push-Ups", description: "Chest and Tris exercise", category: "strength")
Exercise.create(name: "Pull-Ups", description: "Back and Bis exercise", category: "strength")
Exercise.create(name: "Chin-Ups", description: "Back and Bis exercise", category: "strength")
Exercise.create(name: "Lat Pull-Downs", description: "Back exercise", category: "strength")
Exercise.create(name: "Barbell Squat", description: "Leg exercise", category: "strength")
Exercise.create(name: "Leg Press", description: "Leg exercise", category: "strength")
Exercise.create(name: "Dumbbell Lunges", description: "Leg exercise", category: "strength")
Exercise.create(name: "Standing Barbell Curls", description: "Biceps exercise", category: "strength")
Exercise.create(name: "Standing Dumbbell Curls", description: "Biceps exercise", category: "strength")
Exercise.create(name: "Seated Dumbbell Curls", description: "Biceps exercise", category: "strength")
Exercise.create(name: "Skull Crushers", description: "Triceps exercise", category: "strength")
Exercise.create(name: "Cable Pressdowns", description: "Triceps exercise", category: "strength")

#sample cardio exercises
Exercise.create(name: "Running", description: "Outdoors or on treadmill", category: "cardio")
Exercise.create(name: "Yoga", description: "Individual or class", category: "cardio")
Exercise.create(name: "Pilates", description: "Individual or class", category: "cardio")
Exercise.create(name: "Swimming", description: "Freestyle", category: "cardio")
Exercise.create(name: "Biking", description: "Outdoors", category: "cardio")
Exercise.create(name: "Stationary Bike", description: "Indoors bike machine", category: "cardio")
Exercise.create(name: "Jump Roping", description: "Must play montage music", category: "cardio")
Exercise.create(name: "Wii Tennis", description: "Try to tell me this isn't exercise.", category: "cardio")

#sample users
10.times do
  curr_password = "password1"
  User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, age: 20, height: "5'4", weight: 150.0, username: Faker::Internet.user_name, email: Faker::Internet.email, password: curr_password, password_confirmation: curr_password)
end

User.create(first_name: "testy", last_name: "tester", age: 20, height: "5'4", weight: 150.0, username: "testaccount", email: "testaccount@fake.com", password: "password1", password_confirmation: "password1")

#sample workouts
User.all.each do |user|
  da_workout = Workout.create(name: "sample workout #{rand(1..10)}", user: user)
  rand(2..10).times do
    da_workout.exercises << Exercise.all.sample
  end
end
