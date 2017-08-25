FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email 'test@mail.com'
    password "basic_user"
    intent "creator"
    rui "39857342905"
    phone '35342535'
    location 'Test_location'
    plan Plan.find_by_stripe_id('pro_attendee')
  end
end