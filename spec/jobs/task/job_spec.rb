describe Task::Job do
  subject { described_class.new task: task, script: task.script.path, queue: "task-queue" }
  let(:task) { create(:task) }
  let(:job)  { Struct.new(:id).new(1) }

  describe "#exist?" do
    it "detects if the job has been enqueued" do
      expect(subject.exist?).to be false

      Delayed::Job.enqueue subject, queue: "task-queue"
      expect(subject.exist?).to be true
    end
  end

  describe "#before" do
    it "creates a new instance for this job" do
      expect(task.instances.count).to be 0
      expect(subject.before(job)).to be_an Instance
      expect(task.instances.count).to be 1
      expect(task.instances.last.job_id).to eq job.id
    end
  end

  # Using before
  describe "after #before" do
    before { subject.before(job) }

    describe "#perform" do
      it "creates database entries STDOUT" do
        logs = task.instances.last.logs

        expect(logs.count).to be 0

        subject.perform
        expect(logs.count).to be 2

        expect(logs.first.severity).to eq "info"
        expect(logs.first.message).to eq "Hello world"

        expect(logs.last.severity).to eq "error"
        expect(logs.last.message).to eq "Error happening"
      end
    end

    describe "#error" do
      it "creates a fatal log for the instance" do
        logs = task.instances.last.logs
        expect(logs.count).to be 0
        subject.error(job, StandardError.new("Error has occured"))
        expect(logs.count).to be 1
        expect(logs.last.severity).to eq "fatal"
        expect(logs.last.message).to eq "Error has occured"
      end
    end

    describe "#after" do
      it "closes out the instance" do
        instance = task.instances.last
        expect(instance.finished_at).to be nil
        expect(instance.job_id).to eq job.id

        subject.after(job)

        instance.reload
        expect(instance.finished_at).to be_a Time
        expect(instance.job_id).to be nil
      end
    end
  end
end
