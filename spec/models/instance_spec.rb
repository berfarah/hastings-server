require 'rails_helper'

RSpec.describe Instance, type: :model do
  it { should belong_to :task }

  it "validates its duration is not negative" do
    instance = create(:instance)
    instance.finished_at = 5.minutes.ago
    expect(instance).not_to be_valid
  end

  describe "#duration" do
    context "when finished_at is after started_at" do
      subject { create(:instance).duration }
      it { is_expected.to be_a Fixnum }
    end

    context "when finished_at isn't set" do
      subject { create(:instance, finished_at: nil).duration }
      it { is_expected.to be_nil }
    end

    context "when finished_at is before created_at" do
      subject { create(:instance, finished_at: Time.now - 5) }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#started_at" do
    subject { create(:instance) }
    it "aliases to created_at" do
      expect(subject.started_at).to eq(subject.created_at)
    end
  end

  it_behaves_like "loggable", FactoryGirl.create(:instance)
end
