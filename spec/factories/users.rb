FactoryGirl.define do
  factory :user do
    email "user@gmail.com"
    password "password"
    password_confirmation "password"
  end

  trait :invalid do
    email "usergmail.com"
    password "password"
  end

  trait :login_valid do
    email "user@gmail.com"
    password "password"
  end
end