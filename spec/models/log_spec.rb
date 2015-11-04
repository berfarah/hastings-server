require 'rails_helper'

RSpec.describe Log, type: :model do
  it { is_expected.to belong_to(:loggable) }
  it { is_expected.to validate_presence_of :severity }
  it { is_expected.to validate_presence_of :message }

  it "only accepts #{described_class::SEVERITY.to_sentence} as severity" do
    expect(build(:log, severity: "falsey")).not_to be_valid
    expect(build(:log)).to be_valid
  end

  context "scopes" do
    describe ".by_task" do
      let(:task) { create(:task_with_instances) }
      let(:not_in_task) { create(:log) }
      subject { described_class.by_task(task.id) }
      it { is_expected.to include(task.instances.first.logs.first) }
      it { is_expected.not_to include(not_in_task) }
    end
  end
end
