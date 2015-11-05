require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns logs as @logs" do
      log = create(:log)
      get :index
      expect(assigns(:logs)).to eq([log])
    end
  end

  describe "GET #search" do
    it "calls LogsSearch" do
      expect_any_instance_of(LogsSearch).to receive(:search).and_return(Log)
      get :search
    end
  end
end
