require 'pt_summary_reports'

action_mailer = PtSummaryReports::Application.config.action_mailer
conf = PtSummaryReports::Configuration
action_mailer.default_url_options = {
  :host => conf['host']
}

if 'production' == Rails.env
  action_mailer.delivery_method = :smtp
  action_mailer.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => conf['sendgrid_username'],
    :password       => conf['sendgrid_password'],
    :domain         => 'heroku.com'    
  }
else
  if conf['email_delivery']                                                                                                                        
    action_mailer.perform_deliveries = true                                                                                                      
    conf['email_delivery'].each do |k, v|                                                                                                          
      v.symbolize_keys! if v.respond_to?(:symbolize_keys!)                                                                                            
      action_mailer.send("#{k}=", v)                                                                                                             
    end   
  end                                                                                                                                                   
end

PtAccount.secret = conf['secret_key']