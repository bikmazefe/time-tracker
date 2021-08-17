# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: "admin@example.com", password: "12345678", admin: true)

users = User.create([
  {
    email: "user1@example.com",
    password: "12345678",
  },
  {
    email: "user2@example.com",
    password: "12345678",
  },
  {
    email: "user3@example.com",
    password: "12345678",
  },
])

entries = Entry.create([
  {
    user: users[0],
    entry_type: "Personal",
    started_at: DateTime.new(2021, 8, 17, 12, 21),
    finished_at: DateTime.new(2021, 8, 17, 12, 27),
  },
  {
    user: users[0],
    entry_type: "Work",
    started_at: DateTime.new(2021, 8, 17, 16, 18),
    finished_at: DateTime.new(2021, 8, 17, 16, 44),
  },
  {
    user: users[1],
    entry_type: "Work",
    started_at: DateTime.new(2021, 8, 17, 9, 36),
    finished_at: DateTime.new(2021, 8, 17, 9, 51),
  },
  {
    user: users[1],
    entry_type: "Work",
    started_at: DateTime.new(2021, 8, 17, 10, 14),
    finished_at: DateTime.new(2021, 8, 17, 11, 2),
  },
  {
    user: users[2],
    entry_type: "Work",
    started_at: DateTime.new(2021, 8, 17, 9, 21),
    finished_at: DateTime.new(2021, 8, 17, 9, 34),
  },
  {
    user: users[2],
    entry_type: "Personal",
    started_at: DateTime.new(2021, 8, 17, 10, 3),
    finished_at: DateTime.new(2021, 8, 17, 10, 28),
  },
])
