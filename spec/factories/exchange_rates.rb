FactoryBot.define do
  factory :exchange_rate do
    value '30.0'
    valid_until { 1.day.from_now }

    trait :invalid_exchange_rate do
      value nil
      valid_until nil
    end
  end
end
