require 'rails_helper'

RSpec.describe App, type: :model do
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to validate_presence_of :ip }

  it "is expected to work for any IP" do
    expect(build(:app)).to be_valid
  end

  it_behaves_like "loggable", FactoryGirl.create(:app)
end
