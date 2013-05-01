FactoryGirl.define do

  factory :store do
    description   "All things Avengers"
    sequence(:name) { |n| "Avengers#{n}" }
    sequence(:path) { |n| "avengers#{n}" }

    factory :approved_store do
      status   "online"
    end
  end
end
