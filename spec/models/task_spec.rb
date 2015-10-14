require 'rails_helper'

RSpec.describe Task, type: :model, focus: true do
  it { is_expected.to have_many(:instances) }

  # TODO: Add file upload tests

  # Validations
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_numericality_of :interval }

  it "accepts #{described_class::SCALAR.to_sentence} for the scalar" do
    expect(build(:task, scalar: "asdf")).not_to be_valid
    expect(build(:task)).to be_valid
  end

  it "validates that run_at can be parsed as a time" do
    expect(build(:task, run_at: Time.now.strftime("%H:%M"))).to be_valid
    expect(build(:task, run_at: Time.now.strftime("%H:%M:%S"))).to be_valid
  end

  describe "#runtime" do
    context "with just one instance" do
      context "when it's still running" do
        it "returns a nil runtime" do
          task = create(:task)
          task.instances.create(attributes_for(:instance, finished_at: nil))
          expect(task.stats.runtime.sample).to be_empty
        end
      end

      context "when it's done" do
        it "returns its duration with a zero standard deviation" do
          task = create(:task)
          task.instances.create(attributes_for(:instance))
          duration = task.instances.last.duration
          expect(task.stats.runtime.sample).to eq [duration]
        end
      end
    end
  end
end
