require 'spec_helper'

describe "pt_report_schedules/show" do
  before(:each) do
    @pt_report_schedule = assign(:pt_report_schedule, stub_model(PtReportSchedule,
      :pt_account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
