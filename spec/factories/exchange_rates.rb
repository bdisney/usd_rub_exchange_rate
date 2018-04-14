FactoryBot.define do
  factory :exchange_rate do
    value '30.0'
    valid_until { 1.day.from_now }
  end
end
