FactoryGirl.define do
  factory :race do
    name "TestRace"
    description "Test Race description"
    max_attendees "10"
    compensation_amount "1000"
    pieces_amount "50"
    recipients "all"
    race_value "100000"
    category_id 5
    starts_at Time.now.strftime("%m/%d/%Y")
    ends_at Time.now.strftime("%m/%d/%Y")
    status "started"
    kind "pay_for_join"
    permalink "#{Time.now.to_i}-TestRace"
    price 2900
    association :owner, factory: :user
    association :category, factory: :category
  end
end