require 'pt_summary_reports'

action_mailer = PtSummaryReports::Application.config.action_mailer
conf = PtSummaryReports::Configuration
action_mailer.default_url_options = {
  :host => conf['host']
}

if conf['email_delivery']                                                                                                                        
  action_mailer.perform_deliveries = true                                                                                                      
  conf['email_delivery'].each do |k, v|                                                                                                          
    v.symbolize_keys! if v.respond_to?(:symbolize_keys!)                                                                                            
    action_mailer.send("#{k}=", v)                                                                                                             
  end   
end                                                                                                                                                 

PtAccount.secret = conf['secret_key']