include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "#{Faker::Hacker.noun}-#{n}" }
    interval { rand(1..60) }
    scalar   { %w(minutes hours days).sample }
    run_at   { (Time.zone.now + rand(1..60)).strftime("%H:%M") }
    script do
      fixture_file_upload(Rails.root.join("spec", "support", "test_script.sh").to_s)
    end

    after :create do |task, _e|
      task.update_column :script, "test_script.sh"
    end

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
