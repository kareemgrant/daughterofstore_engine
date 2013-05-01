FactoryGirl.define do

  factory :auction do
    association :store, factory: :approved_store

    expiration_date   Time.now + 7200
    starting_bid      0
    shipping_options  'domestic'
    active            true
  end
end

