require 'spec_helper'

describe "pt_accounts/index" do
  before(:each) do
    assign(:pt_accounts, [
      stub_model(PtAccount,
        :email => "Email",
        :password_digest => "Password Digest",
        :api_token => "Api Token",
        :user => nil
      ),
      stub_model(PtAccount,
        :email => "Email",
        :password_digest => "Password Digest",
        :api_token => "Api Token",
        :user => nil
      )
    ])
  end

  it "renders a list of pt_accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Api Token".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
