FactoryGirl.define do
  factory :instance do
    finished_at { Time.zone.now + (rand(1..30)).minutes }
    failed { [true, false].sample }
    task

    factory :instance_with_logs do
      transient do
        logs_count { rand(19) + 1 }
      end

      after :create do |instance, e|
        FactoryGirl.create_list(:log, e.logs_count, loggable: instance)
      end
    end
  end
end
