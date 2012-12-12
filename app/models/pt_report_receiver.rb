class PtReportReceiver < ActiveRecord::Base
  belongs_to :pt_report_schedule
  attr_accessible :pt_membership_id
end
