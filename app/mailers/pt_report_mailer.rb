class PtReportMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def daily_report(daily_project_reports)
    @daily_project_reports = daily_project_reports
    mail(to: daily_project_reports[:recipients], 
      subject: "Daily Pivotal Tracker Summary Report")
  end
  
  def credentials_mismatch_notification(pt_report_schedule)
    @pt_report_schedule = pt_report_schedule
    mail(to: "#{pt_report_schedule.pt_account.email}", 
      subject: "Credentials Mismatch: Report Skipped")
  end
end
