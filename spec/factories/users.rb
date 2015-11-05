FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    sequence(:email) { |n| "user#{n}@whitelisted.com" }
    password { Faker::Internet.password(10) }
    confirmed_at { 5.minutes.ago }
  end
end
