class PtReportMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def daily_report(daily_project_reports)
    @daily_project_reports = daily_project_reports
    mail(:to => daily_project_reports[:recipients], 
      :subject => "Daily Pivotal Tracker Summary Report")
  end
end
