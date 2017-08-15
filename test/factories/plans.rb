FactoryGirl.define do
  factory :plan do
    name 'basic'
    stripe_id 'basic'
    interval 'month'
    amount 2900
  end
end