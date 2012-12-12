require 'spec_helper'

describe "pt_report_schedules/index" do
  before(:each) do
    assign(:pt_report_schedules, [
      stub_model(PtReportSchedule,
        :pt_account => nil
      ),
      stub_model(PtReportSchedule,
        :pt_account => nil
      )
    ])
  end

  it "renders a list of pt_report_schedules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
