namespace :pt_summary_reports do
  desc 'Send a daily email digest with the stories that were started, finished, delivered and discussed the previous day.'
  task :send_daily_report => :environment do
    PtReportSchedule.send_daily_report
  end
end
