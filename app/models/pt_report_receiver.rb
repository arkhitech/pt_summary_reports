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
  belongs_to :pt_report_schedule, inverse_of: :pt_report_receivers
  attr_accessible :pt_membership_id  
  
  def pt_membership_name
    pt_membership = pt_report_schedule.pt_account.pt_memberships_by_id[pt_membership_id]
    (pt_membership && pt_membership.name) || pt_membership_id    
  end
end
