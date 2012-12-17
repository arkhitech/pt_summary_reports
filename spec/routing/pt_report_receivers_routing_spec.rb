require "spec_helper"

describe PtReportReceiversController do
  describe "routing" do

    it "routes to #show" do
      get("/pt_report_receivers/1").should route_to("pt_report_receivers#show", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pt_report_receivers/1").should route_to("pt_report_receivers#destroy", :id => "1")
    end

  end
end
