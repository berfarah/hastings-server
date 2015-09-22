require "rails_helper"

module Hastings
  RSpec.describe InstancesController, type: :routing do
    routes { Hastings::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        expect(:get => "/1/instances").to route_to("hastings/instances#index", task_id: "1")
      end

      it "routes to #show" do
        expect(:get => "/instances/1").to route_to("hastings/instances#show", :id => "1")
      end
    end
  end
end
