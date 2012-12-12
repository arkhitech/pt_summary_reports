require "spec_helper"

describe PtReportReceiversController do
  describe "routing" do

    it "routes to #index" do
      get("/pt_report_receivers").should route_to("pt_report_receivers#index")
    end

    it "routes to #new" do
      get("/pt_report_receivers/new").should route_to("pt_report_receivers#new")
    end

    it "routes to #show" do
      get("/pt_report_receivers/1").should route_to("pt_report_receivers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pt_report_receivers/1/edit").should route_to("pt_report_receivers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pt_report_receivers").should route_to("pt_report_receivers#create")
    end

    it "routes to #update" do
      put("/pt_report_receivers/1").should route_to("pt_report_receivers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pt_report_receivers/1").should route_to("pt_report_receivers#destroy", :id => "1")
    end

  end
end
