FactoryGirl.define do
  factory :attendee do
    pieces { Array.new(3) { FactoryGirl.build(:piece) } }
  end
end