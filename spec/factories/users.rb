FactoryGirl.define do

  factory :user do
    full_name     "Tony Stark"
    display_name  "Iron Man"
    password      "password"
    sequence(:email) { |n| "ironman#{n}@example.com" }

    factory :invalid_user do
      full_name     nil
    end
  end
end
