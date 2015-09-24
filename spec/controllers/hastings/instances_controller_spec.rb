require 'rails_helper'

module Hastings
  RSpec.describe InstancesController, type: :controller do
    routes { Engine.routes }
    before { @task = Task.create!(name: "Hello hello", ip: "123.123.123.123", external: true) }

    # This should return the minimal set of attributes required to create a valid
    # Instance. As you add validations to Instance, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { {} }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # InstancesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all instances as @instances" do
        instance = @task.instances.create! valid_attributes
        get :index, { task_id: @task }, valid_session
        expect(assigns(:instances)).to eq([instance])
      end
    end

    describe "GET #show" do
      it "assigns the requested instance as @instance" do
        instance = @task.instances.create! valid_attributes
        get :show, {:id => instance.to_param}, valid_session
        expect(assigns(:instance)).to eq(instance)
      end
    end
  end
end
