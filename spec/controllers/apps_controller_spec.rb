require 'rails_helper'

RSpec.describe AppsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }
  after  { sign_out :user }
  let(:valid_session) { {} }

  describe "PUT #update" do
    it_behaves_like "an updatable model", :app
  end
end
