require 'spec_helper'

describe "pt_report_receivers/new" do
  before(:each) do
    assign(:pt_report_receiver, stub_model(PtReportReceiver,
      :pt_report_schedule => nil,
      :pt_membership_id => 1
    ).as_new_record)
  end

  it "renders new pt_report_receiver form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pt_report_receivers_path, :method => "post" do
      assert_select "input#pt_report_receiver_pt_report_schedule", :name => "pt_report_receiver[pt_report_schedule]"
      assert_select "input#pt_report_receiver_pt_membership_id", :name => "pt_report_receiver[pt_membership_id]"
    end
  end
end
