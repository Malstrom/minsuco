FactoryGirl.define do
  factory :attendee do
    join_value 1000
    association :user, factory: :user
    association :race, factory: :race
  end
end