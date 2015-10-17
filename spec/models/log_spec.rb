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
    before do
      @yesterday = create(:log)
      @yesterday.created_at = Time.zone.yesterday
      @yesterday.save!
      @today     = create(:log)
      @tomorrow  = create(:log)
      @tomorrow.created_at = Time.zone.tomorrow
      @tomorrow.save!
    end

    after do
      [@yesterday, @today, @tomorrow].each(&:destroy!)
    end

    describe ".date" do
      subject { described_class.date(Time.zone.today) }
      it { is_expected.to eq([@today]) }
    end

    describe ".range" do
      subject { described_class.range(Time.zone.yesterday, Time.zone.today) }
      it { is_expected.to include(@yesterday) }
      it { is_expected.to include(@today) }
    end

    describe ".by_task" do
      let(:task) { create(:task_with_instances) }
      after { task.destroy! }
      subject { described_class.by_task(task.id) }
      it { is_expected.to include(task.instances.first.logs.first) }
      it { is_expected.not_to include(@yesterday) }
    end
  end
end
