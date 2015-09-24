require 'rails_helper'

module Hastings
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
        @yesterday.created_at = Date.yesterday
        @yesterday.save!

        @today = create(:log)

        @tomorrow = create(:log)
        @tomorrow.created_at = Date.tomorrow
        @tomorrow.save!
      end

      describe ".date" do
        subject { described_class.date(Date.today) }
        it { is_expected.to eq [@today] }
      end

      describe ".range" do
        subject { described_class.range(Date.yesterday, Date.today) }
        it { is_expected.to eq [@yesterday, @today] }
      end
    end
  end
end
