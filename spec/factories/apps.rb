FactoryGirl.define do
  factory :app do
    name { Faker::Hacker.noun }
    ip { Faker::Internet.ip_v4_address }

    factory :app_with_logs do
      transient do
        logs_count { rand(19) + 1 }
      end

      after :create do |app, e|
        FactoryGirl.create_list(:log, e.logs_count, loggable: app)
      end
    end
  end
end
