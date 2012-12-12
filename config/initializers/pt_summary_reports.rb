require 'pt_summary_reports'

PtSummaryReports::Application.config.action_mailer.default_url_options = {
  :host => PtSummaryReports::Configuration['host']
}
