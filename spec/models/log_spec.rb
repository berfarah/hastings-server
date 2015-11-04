require 'rails_helper'

RSpec.describe Log, type: :model do
  it { is_expected.to belong_to(:loggable) }
  it { is_expected.to validate_presence_of :severity }
  it { is_expected.to validate_presence_of :message }

  it "only accepts #{described_class::SEVERITY.to_sentence} as severity" do
    expect(build(:log, severity: "falsey")).not_to be_valid
    expect(build(:log)).to be_valid
  end
end
