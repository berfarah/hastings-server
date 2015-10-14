describe Task::NowJob do
  subject { described_class.new task: task, script: task.script, queue: "task-queue" }
  let(:task) { create(:task) }
  let(:job)  { Struct.new(:id).new(1) }

  it { is_expected.to be_a Task::Job }

  describe "#before" do
    it "pauses the recurring task after running" do
      expect_any_instance_of(TaskDispatcher).to receive(:pause)
      subject.before(job)
    end
  end

  describe "#after" do
    it "unpauses the recurring task after running" do
      subject.before(job)
      expect_any_instance_of(TaskDispatcher).to receive(:unpause)
      subject.after(job)
    end
  end
end
