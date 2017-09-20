FactoryGirl.define do
  factory :piece do
    name Faker::Name.name
    value 1000
    duration 5
  end
end