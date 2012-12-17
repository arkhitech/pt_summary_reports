require 'faker'

FactoryGirl.define do
  factory :pt_account do 
    email 'hisham.malik@gmail.com'
    password '1332'
    user
  end
end
