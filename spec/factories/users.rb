require 'faker'

FactoryGirl.define do
  factory :user do
    email 'hisham@arkhitech.com'
    password 'testing'
    password_confirmation 'testing'
  end
end
