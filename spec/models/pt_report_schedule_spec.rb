# == Schema Information
#
# Table name: pt_report_schedules
#
#  id            :integer          not null, primary key
#  pt_account_id :integer
#  report_time   :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe PtReportSchedule do
  pending "add some examples to (or delete) #{__FILE__}"
end
