require 'spec_helper'

describe "pt_accounts/show" do
  before(:each) do
    @pt_account = assign(:pt_account, stub_model(PtAccount,
      :email => "Email",
      :password_digest => "Password Digest",
      :api_token => "Api Token",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Password Digest/)
    rendered.should match(/Api Token/)
    rendered.should match(//)
  end
end
