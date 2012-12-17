require 'spec_helper'

describe "pt_accounts/edit" do
  before(:each) do
    @pt_account = assign(:pt_account, stub_model(PtAccount,
      :email => "MyString",
      :password_digest => "MyString",
      :api_token => "MyString",
      :user => nil
    ))
  end

  it "renders the edit pt_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pt_accounts_path(@pt_account), :method => "post" do
      assert_select "input#pt_account_email", :name => "pt_account[email]"
      assert_select "input#pt_account_password", :name => "pt_account[password_digest]"
      assert_select "input#pt_account_password_confirmation", :name => "pt_account[api_token]"
    end
  end
end
