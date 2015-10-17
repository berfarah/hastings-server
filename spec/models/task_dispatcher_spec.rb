describe TaskDispatcher do
  subject { described_class.new(task) }
  let(:task) { create(:task, enabled: enabled) }
  let(:enabled) { true }

  describe "#run_now" do
    it "run the same job twice unless it's already run" do
      expect(Delayed::Job.count).to be 0
      expect(subject.run_now).not_to be false
      expect(Delayed::Job.count).to be 1
      expect(subject.run_now).to be false
      expect(Delayed::Job.count).to be 1
    end
  end

  describe "#running?" do
    before { create(:instance, job_id: running, task: task) }
    after  { task.destroy! }
    subject { super().running? }
    context "when the last job is running" do
      let(:running) { 1 }
      it { is_expected.to be_truthy }
    end

    context "when the last job isn't running" do
      let(:running) { nil }
      it { is_expected.to be_falsy }
    end
  end

  describe "#failed?" do
    before { create(:instance, failed: failed, task: task) }
    after  { task.destroy! }
    subject { super().failed? }
    context "when the last job is running" do
      let(:failed) { true }
      it { is_expected.to be true }
    end

    context "when the last job isn't running" do
      let(:failed) { false }
      it { is_expected.to be false }
    end
  end

  describe "#update_schedule" do
    context "when the task is enabled" do
      it "(re)schedules the task" do
        expect(Delayed::Job.count).to be 0
        subject.update_schedule
        expect(Delayed::Job.count).to be 1
      end
    end

    context "when the task is disabled" do
      let(:enabled) { false }

      it "doesn't (re)schedule the task" do
        expect(Delayed::Job.count).to be 0
        subject.update_schedule
        expect(Delayed::Job.count).to be 0
      end
    end
  end

  describe "#unschedule" do
    it "delegates to Task::RecurringJob" do
      expect(Task::RecurringJob).to receive(:unschedule)
        subject.unschedule
    end
  end

  describe "#pause" do
    it "delegates to Task::RecurrinJob" do
      expect(Task::RecurringJob).to receive(:pause)
      subject.pause
    end
  end

  describe "#unpause" do
    it "delegates to Task::RecurrinJob" do
      expect(Task::RecurringJob).to receive(:unpause)
      subject.unpause
    end
  end
end
