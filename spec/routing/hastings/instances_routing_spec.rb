require "rails_helper"

RSpec.describe InstancesController, type: :routing do

  describe "routing" do

    it "routes to #index" do
      expect(:get => "/1/instances").to route_to("instances#index", task_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/instances/1").to route_to("instances#show", :id => "1")
    end
  end
end
