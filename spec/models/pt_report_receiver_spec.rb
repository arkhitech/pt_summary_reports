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

require 'spec_helper'

describe PtReportReceiver do
  pending "add some examples to (or delete) #{__FILE__}"
end
