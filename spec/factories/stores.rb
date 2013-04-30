FactoryGirl.define do

  factory :store do
    name          "Avengers"
    path          "avengers"
    description   "All things Avengers"
    status        "pending"

    factory :invalid_store do
      name     nil
    end
  end
end
