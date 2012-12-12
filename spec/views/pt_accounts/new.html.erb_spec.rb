require 'spec_helper'

describe "pt_accounts/new" do
  before(:each) do
    assign(:pt_account, stub_model(PtAccount,
      :email => "MyString",
      :password_digest => "MyString",
      :api_token => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new pt_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pt_accounts_path, :method => "post" do
      assert_select "input#pt_account_email", :name => "pt_account[email]"
      assert_select "input#pt_account_password_digest", :name => "pt_account[password_digest]"
      assert_select "input#pt_account_api_token", :name => "pt_account[api_token]"
      assert_select "input#pt_account_user", :name => "pt_account[user]"
    end
  end
end
