require 'spec_helper'

describe "pt_report_schedules/edit" do
  before(:each) do
    @pt_report_schedule = assign(:pt_report_schedule, stub_model(PtReportSchedule,
      :pt_account => nil
    ))
  end

  it "renders the edit pt_report_schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pt_report_schedules_path(@pt_report_schedule), :method => "post" do
      assert_select "input#pt_report_schedule_pt_account", :name => "pt_report_schedule[pt_account]"
    end
  end
end
