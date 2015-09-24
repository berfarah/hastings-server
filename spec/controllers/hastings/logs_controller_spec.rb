require 'rails_helper'

module Hastings
  RSpec.describe LogsController, type: :controller do
    routes { Hastings::Engine.routes }
    before { @instance = Instance.create! }

    # This should return the minimal set of attributes required to create a valid
    # Log. As you add validations to Log, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      { severity: :info, message: "Test message" }
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # LogsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      describe "when accessed directly" do
        it "assigns logs as @logs" do
          log = Log.create! valid_attributes
          get :index, {}, valid_session
          expect(assigns(:logs)).to eq([log])
        end
      end

      describe "when accessed via Instance" do
        it "assigns all @instance.logs as @logs" do
          log = @instance.logs.create! valid_attributes
          get :index, { instance_id: @instance }, valid_session
          expect(assigns(:logs)).to eq([log])
        end
      end
    end
  end
end
