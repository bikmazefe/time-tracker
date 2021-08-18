FactoryBot.define do
  factory :entry do
    comment { "MyString" }
    entry_type { "test type" }
    association(:user)
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "12345678" }
  end
end
