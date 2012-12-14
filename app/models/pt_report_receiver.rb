# == Schema Information
#
# Table name: pt_report_receivers
#
#  id                    :integer          not null, primary key
#  pt_report_schedule_id :integer
#  pt_membership_id      :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class PtReportReceiver < ActiveRecord::Base
  belongs_to :pt_report_schedule
  attr_accessible :pt_membership_id  
end
