require "rails_helper"

module Hastings
  RSpec.describe TasksController, type: :routing do
    routes { Hastings::Engine.routes }
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/tasks").to route_to("hastings/tasks#index")
      end

      it "routes to #new" do
        expect(:get => "/tasks/new").to route_to("hastings/tasks#new")
      end

      it "routes to #show" do
        expect(:get => "/tasks/1").to route_to("hastings/tasks#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/tasks/1/edit").to route_to("hastings/tasks#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/tasks").to route_to("hastings/tasks#create")
      end

      it "routes to #update via PUT" do
        expect(:put => "/tasks/1").to route_to("hastings/tasks#update", :id => "1")
      end

      it "routes to #update via PATCH" do
        expect(:patch => "/tasks/1").to route_to("hastings/tasks#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/tasks/1").to route_to("hastings/tasks#destroy", :id => "1")
      end

    end
  end
end
