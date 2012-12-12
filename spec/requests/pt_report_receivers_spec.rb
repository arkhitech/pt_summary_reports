require 'spec_helper'

describe "PtReportReceivers" do
  describe "GET /pt_report_receivers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get pt_report_receivers_path
      response.status.should be(200)
    end
  end
end
