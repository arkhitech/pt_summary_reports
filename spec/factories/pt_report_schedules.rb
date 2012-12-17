require 'faker'

FactoryGirl.define do
  factory :pt_report_schedule do
    report_time '16:00'
    pt_account

    factory :pt_report_schedule_with_receivers do
      ignore do
        receivers_count 5
      end

      after(:create) do |pt_report_schedule, evaluator|
        FactoryGirl.create_list(:pt_report_receiver, evaluator.receivers_count, pt_report_schedule: pt_report_schedule)
      end      
    end
  end
end
