FactoryGirl.define do
  factory :task do
    name { Faker::Hacker.noun }
    interval { rand(1..60) }
    scalar   { %w(minutes hours days).sample }
    run_at   { (Time.now + rand(1..60)).strftime("%H:%M") }

    factory :task_with_instances do
      transient do
        instances_count { rand(4) + 1 }
      end

      after :create do |task, e|
        FactoryGirl.create_list(:instance_with_logs, e.instances_count, task: task)
      end
    end
  end
end
