module PtReportSchedulesHelper
  #inspired from redmine watchers_checkboxes method
  def pt_report_receiver_checkboxes(pt_report_schedule)
    available_pt_memberships = pt_report_schedule.available_pt_memberships
    available_pt_memberships.map do |available_pt_membership|
      checked = pt_report_schedule.pt_report_receiver?(available_pt_membership)                                                                                                 
      tag = check_box_tag 'pt_report_schedule[pt_report_receivers_attributes][][pt_membership_id]', 
        available_pt_membership.id, checked, class: 'check_box_field'
      content_tag 'label', "#{tag} #{h(available_pt_membership.name)}".html_safe,
                  :id => "pt_report_schedule_pt_report_receiver_ids_#{available_pt_membership.id}",
                  :class => "control-label"
    end.join.html_safe         
  end
end
