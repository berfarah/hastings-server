FactoryGirl.define do
  factory :log, class: Hastings::Log do
    severity { %i(info warn error fatal).sample }
    message  { Faker::Lorem.sentence }
    
  end
end
