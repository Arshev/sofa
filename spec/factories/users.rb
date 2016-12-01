FactoryGirl.define do
  sequence :email do |n|
    "user#{n + rand(100..1000)}@test.com"
  end
  
  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end
end
