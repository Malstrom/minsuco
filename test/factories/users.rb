FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.free_email
    password "basic_user"
    intent "creator"
    rui "39857342905"
    plan Plan.find_by_stripe_id('basic')
  end
end