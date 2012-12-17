namespace :heroku do
  task :config do
    require 'pt_summary_reports'
    
    conf = PtSummaryReports::Configuration.load(env: 'production')
    command = "heroku config:add"
    conf.each {|key, val| command << " #{key}=#{val} " if val }
    system command
    #puts "#{command}"
  end
end
