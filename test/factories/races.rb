FactoryGirl.define do
  factory :race do
    name "TestRace"
    description "Test Race description"
    max_attendees "10"
    commission "1000"
    min_pieces "50"
    recipients "for_all"
    race_value "100000"
    category_id 5
    starts_at Time.now.strftime("%d/%m/%Y")
    ends_at((Time.now + 100.hours).strftime("%d/%m/%Y") )
    status "started"
    kind "pay_for_join"
    permalink "#{Time.now.to_i}-TestRace"
    price 2900
    association :owner, factory: :user
    association :category, factory: :category
  end
end