describe Task::RecurringJob do
  subject { described_class.new task: task, script: task.script, queue: "task-queue" }
  let(:task) { create(:task) }
  it { is_expected.to be_a Task::Job }
  it { is_expected.to be_a RecurringJobConcern }
end
