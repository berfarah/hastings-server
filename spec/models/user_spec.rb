require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :tasks }
  it { is_expected.to have_many :apps }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of :username }

  it "accepts only whitelisted emails" do
    expect(build(:user, email: "ber@bernardo.me")).not_to be_valid
    expect(build(:user)).to be_valid
  end
end
