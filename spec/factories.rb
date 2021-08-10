FactoryBot.define do
  factory :entry do
    comment { "MyString" }
    entry_type { "test type" }
    started_at { DateTime.new(2021, 10, 31, 2, 2, 2, "+03:00") }
    finished_at { DateTime.new(2021, 10, 31, 5, 23, 10, "+03:00") }
    association(:user)
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "12345678" }
  end
end
