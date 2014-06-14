require "spec_helper"

describe FacebookPlacesController do
  describe "routing" do

    it "routes to #index" do
      get("/facebook_places").should route_to("facebook_places#index")
    end

    it "routes to #new" do
      get("/facebook_places/new").should route_to("facebook_places#new")
    end

    it "routes to #show" do
      get("/facebook_places/1").should route_to("facebook_places#show", :id => "1")
    end

    it "routes to #edit" do
      get("/facebook_places/1/edit").should route_to("facebook_places#edit", :id => "1")
    end

    it "routes to #create" do
      post("/facebook_places").should route_to("facebook_places#create")
    end

    it "routes to #update" do
      put("/facebook_places/1").should route_to("facebook_places#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/facebook_places/1").should route_to("facebook_places#destroy", :id => "1")
    end

  end
end
