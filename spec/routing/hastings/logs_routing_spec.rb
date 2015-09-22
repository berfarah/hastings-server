require "rails_helper"

module Hastings
  RSpec.describe LogsController, type: :routing do
    routes { Hastings::Engine.routes }
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/logs").to route_to("hastings/logs#index")
      end

      it "routes to #new" do
        expect(:get => "/logs/new").to route_to("hastings/logs#new")
      end

      it "routes to #show" do
        expect(:get => "/logs/1").to route_to("hastings/logs#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/logs/1/edit").to route_to("hastings/logs#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/logs").to route_to("hastings/logs#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/logs/1").to route_to("hastings/logs#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/logs/1").to route_to("hastings/logs#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/logs/1").to route_to("hastings/logs#destroy", :id => "1")
      end

    end
  end
end
