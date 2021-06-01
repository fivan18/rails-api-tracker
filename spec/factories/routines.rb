FactoryBot.define do
  factory :routine do
    sequence(:day) { |n| n.days.ago }
    user
  end
end
