require 'spec_helper'

describe "pt_report_receivers/show" do
  before(:each) do
    @pt_report_receiver = assign(:pt_report_receiver, stub_model(PtReportReceiver,
      :pt_report_schedule => nil,
      :pt_membership_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
