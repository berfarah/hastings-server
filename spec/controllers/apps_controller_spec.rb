require 'rails_helper'

RSpec.describe AppsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }
  after  { sign_out :user }
  let(:valid_session) { {} }
  let(:valid_attributes) { attributes_for(:app) }
  let(:invalid_attributes) { { name: "Broken name", ip: "not valid" } }

  describe "GET #log" do
    let(:app) { create(:app) }
    let(:log) { { severity: "info", message: "Hello world" } }

    context "with a valid IP" do
      it "creates logs for given app" do
        @request.env["REMOTE_ADDR"] = app.ip
        expect do
          post :log, { id: app.id, log: log }, valid_session
        end.to change(app.logs, :count).by(1)
      end

      context "but invalid input" do
        it "creates logs for given app" do
          @request.env["REMOTE_ADDR"] = app.ip
          expect do
            post :log, { id: app.id, log: log.merge(severity: "invalid") }, valid_session
          end.not_to change(app.logs, :count)
        end
      end
    end

    context "with an invalid IP" do
      it "creates logs for given app" do
        @request.env["REMOTE_ADDR"] = "0.0.0.0"
        expect do
          post :log, { id: app.id, log: log }, valid_session
        end.not_to change(app.logs, :count)
      end
    end
  end

  describe "GET #index" do
    it "assigns all apps as @apps" do
      app = create(:app)
      get :index, {}, valid_session
      expect(assigns(:apps)).to eq([app])
    end
  end

  describe "GET #show" do
    it "assigns the requested app as @app" do
      app = App.create! valid_attributes
      get :show, {:id => app.to_param}, valid_session
      expect(assigns(:app)).to eq(app)
    end
  end

  describe "GET #new" do
    it "assigns a new app as @app" do
      get :new, {}, valid_session
      expect(assigns(:app)).to be_a_new(App)
    end
  end

  describe "GET #edit" do
    it "assigns the requested app as @app" do
      app = App.create! valid_attributes
      get :edit, {:id => app.to_param}, valid_session
      expect(assigns(:app)).to eq(app)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new App" do
        expect {
          post :create, {:app => valid_attributes}, valid_session
        }.to change(App, :count).by(1)
      end

      it "assigns a newly created app as @app" do
        post :create, {:app => valid_attributes}, valid_session
        expect(assigns(:app)).to be_a(App)
        expect(assigns(:app)).to be_persisted
      end

      it "redirects to the created app" do
        post :create, {:app => valid_attributes}, valid_session
        expect(response).to redirect_to(App.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved app as @app" do
        post :create, {:app => invalid_attributes}, valid_session
        expect(assigns(:app)).to be_a_new(App)
      end

      it "re-renders the 'new' template" do
        post :create, {:app => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    it_behaves_like "an updatable model", :app

    context "with valid params" do
      it "updates the requested app" do
        app = App.create! valid_attributes
        new_attr = attributes_for(:app)
        put :update, {:id => app.to_param, :app => new_attr}, valid_session
        app.reload
        expect(app.name).to eq(new_attr[:name])
      end

      it "assigns the requested app as @app" do
        app = App.create! valid_attributes
        put :update, {:id => app.to_param, :app => valid_attributes}, valid_session
        expect(assigns(:app)).to eq(app)
      end

      it "redirects to the app" do
        attrs = attributes_for(:app)
        app = App.create! attrs
        put :update, {:id => app.to_param, :app => attrs}, valid_session
        expect(response).to redirect_to(app)
      end
    end

    context "with invalid params" do
      it "assigns the app as @app" do
        app = App.create! valid_attributes
        put :update, {:id => app.to_param, :app => invalid_attributes}, valid_session
        expect(assigns(:app)).to eq(app)
      end

      it "re-renders the 'edit' template" do
        app = App.create! valid_attributes
        put :update, {:id => app.to_param, :app => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested app" do
      app = App.create! valid_attributes
      expect {
        delete :destroy, {:id => app.to_param}, valid_session
      }.to change(App, :count).by(-1)
    end

    it "redirects to the apps list" do
      app = App.create! valid_attributes
      delete :destroy, {:id => app.to_param}, valid_session
      expect(response).to redirect_to(apps_url)
    end
  end
end
