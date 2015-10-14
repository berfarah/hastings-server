describe RecurringJobConcern do
  # Need to name our subject since RecurringJob relies on class names for
  # serialization
  before do
    class ExampleJob; include RecurringJobConcern; def perform; end end
    class OtherJob; include RecurringJobConcern; def perform; end end
  end

  after do
    Object.send(:remove_const, :ExampleJob)
    Object.send(:remove_const, :OtherJob)
  end

  subject { ExampleJob }
  let(:other) { OtherJob }
  let(:opts) { { queue: "my-queue" } }

  describe ".schedule" do
    it "creates a scheduled job that starts in 5 minutes" do
      expect(Delayed::Job.count).to be 0
      subject.schedule(opts)
      expect(Delayed::Job.count).to be 1
      expect(Delayed::Job.last.run_at).to be_within(1.second).of Time.zone.now + 5
    end

    it "doesn't schedule a job if there is an existing job" do
      expect(Delayed::Job.count).to be 0
      subject.schedule(opts)
      expect(Delayed::Job.count).to be 1
      subject.schedule(opts)
      expect(Delayed::Job.count).to be 1
    end
  end

  describe ".unschedule" do
    it "unschedules itself (and no other jobs)" do
      expect(Delayed::Job.count).to be 0
      subject.schedule(opts)
      other.schedule(opts)
      expect(Delayed::Job.count).to be 2
      subject.unschedule(opts)
      expect(Delayed::Job.count).to be 1
    end
  end

  describe ".pause" do
    it "locks the job as if it were being processed" do
      subject.schedule(opts)
      expect(Delayed::Job.last.locked_at).to be_nil
      expect(Delayed::Job.last.locked_by).to be_nil
      subject.pause(opts)
      expect(Delayed::Job.last.locked_at).to be_within(1.second).of Time.now
      expect(Delayed::Job.last.locked_by).to eq "web_server"
    end
  end

  describe ".pause" do
    it "unlocks the job for processing" do
      subject.schedule(opts)
      subject.pause(opts)
      expect(Delayed::Job.last.locked_at).to be_within(1.second).of Time.now
      expect(Delayed::Job.last.locked_by).to eq "web_server"
      subject.unpause(opts)
      expect(Delayed::Job.last.locked_at).to be_nil
      expect(Delayed::Job.last.locked_by).to be_nil
    end
  end
end
