require "rails_helper"

RSpec.describe VolunteersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/volunteers").to route_to("volunteers#index")
    end

    it "routes to #new" do
      expect(:get => "/volunteers/new").to route_to("volunteers#new")
    end

    it "routes to #show" do
      expect(:get => "/volunteers/1").to route_to("volunteers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/volunteers/1/edit").to route_to("volunteers#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/volunteers").to route_to("volunteers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/volunteers/1").to route_to("volunteers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/volunteers/1").to route_to("volunteers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/volunteers/1").to route_to("volunteers#destroy", :id => "1")
    end
  end
end
