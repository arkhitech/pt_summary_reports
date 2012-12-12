require 'spec_helper'

describe "pt_report_receivers/index" do
  before(:each) do
    assign(:pt_report_receivers, [
      stub_model(PtReportReceiver,
        :pt_report_schedule => nil,
        :pt_membership_id => 1
      ),
      stub_model(PtReportReceiver,
        :pt_report_schedule => nil,
        :pt_membership_id => 1
      )
    ])
  end

  it "renders a list of pt_report_receivers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
