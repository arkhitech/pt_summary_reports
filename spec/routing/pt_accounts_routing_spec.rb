require "spec_helper"

describe PtAccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/pt_accounts").should route_to("pt_accounts#index")
    end

    it "routes to #new" do
      get("/pt_accounts/new").should route_to("pt_accounts#new")
    end

    it "routes to #show" do
      get("/pt_accounts/1").should route_to("pt_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pt_accounts/1/edit").should route_to("pt_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pt_accounts").should route_to("pt_accounts#create")
    end

    it "routes to #update" do
      put("/pt_accounts/1").should route_to("pt_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pt_accounts/1").should route_to("pt_accounts#destroy", :id => "1")
    end

  end
end
