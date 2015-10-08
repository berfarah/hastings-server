FactoryGirl.define do
  factory :log do
    severity { %i(info warn error fatal).sample }
    message  { Faker::Lorem.sentence }

  end
end
