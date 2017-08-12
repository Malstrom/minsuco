FactoryGirl.define do
  factory :attendee do
    association :attendee, factory: :user
    association :race, factory: :race
  end
end