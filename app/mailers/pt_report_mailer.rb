class PtReportMailer < ActionMailer::Base
  default from: PtSummaryReports::Configuration['mailer_sender']
  
  def daily_report(daily_project_reports_with_recipients)
    @daily_project_reports = daily_project_reports_with_recipients[:projects]
    mail(to: daily_project_reports_with_recipients[:recipients], 
      subject: "Daily Pivotal Tracker Summary Report")
  end
  
  def credentials_mismatch_notification(pt_report_schedule)
    @pt_report_schedule = pt_report_schedule
    mail(to: "#{pt_report_schedule.pt_account.email}", 
      subject: "Credentials Mismatch: Report Skipped")
  end
end
