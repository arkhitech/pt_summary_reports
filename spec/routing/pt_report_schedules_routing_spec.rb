require "spec_helper"

describe PtReportSchedulesController do
  describe "routing" do

    it "routes to #index" do
      get("/pt_report_schedules").should route_to("pt_report_schedules#index")
    end

    it "routes to #new" do
      get("/pt_report_schedules/new").should route_to("pt_report_schedules#new")
    end

    it "routes to #show" do
      get("/pt_report_schedules/1").should route_to("pt_report_schedules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pt_report_schedules/1/edit").should route_to("pt_report_schedules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pt_report_schedules").should route_to("pt_report_schedules#create")
    end

    it "routes to #update" do
      put("/pt_report_schedules/1").should route_to("pt_report_schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pt_report_schedules/1").should route_to("pt_report_schedules#destroy", :id => "1")
    end

  end
end
