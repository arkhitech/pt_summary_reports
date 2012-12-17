require "spec_helper"

describe PtReportSchedulesController do
  describe "routing" do

    it "routes to #edit" do
      get("/pt_accounts/1/pt_report_schedules/1/edit").should route_to("pt_report_schedules#edit", id: "1", pt_account_id: '1')
    end

    it "routes to #create" do
      post("/pt_accounts/1/pt_report_schedules").should route_to("pt_report_schedules#create")
    end

    it "routes to #update" do
      put("/pt_accounts/1/pt_report_schedules/1").should route_to("pt_report_schedules#update", id: "1", pt_account_id: '1')
    end

    it "routes to #destroy" do
      delete("/pt_accounts/1/pt_report_schedules/1").should route_to("pt_report_schedules#destroy", id: "1", pt_account_id: '1')
    end

  end
end
