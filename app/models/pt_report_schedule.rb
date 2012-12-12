class PtReportSchedule < ActiveRecord::Base
  belongs_to :pt_account
  attr_accessible :report_time

  has_many :pt_report_recievers, dependent: :destroy

  class << self

    # The frequency at which the scheduler runs. Used to avoid sending
    # duplicate reports
    def send_daily_report
      report_time = Time.now

      pt_report_schedules = 
        PtReportSchedule.where('report_time <= TIME(?) AND updated_at <= ?', 
        report_time, report_time.beginning_of_day)

      PtReportSchedule.transaction do
        pt_report_schedules.each do |pt_report_schedule|
          pt_report_schedule.send_daily_report
        end
      end
    end    
  end

  def send_daily_report
    daily_project_reports = generate_daily_project_reports
    PtReportMailer.daily_report(daily_project_reports).deliver
  end

  def get_recipients(pt_projects)
    report_receivers = pt_report_receivers 
    
    #create a set from report receiver to quickly match email addresses (n+n)
    report_receiver_ids = Set.new
    report_receivers.each do |report_receiver|
      report_receiver_ids << report_receiver.pt_membership_id
    end
    
    init_pt_client
    memberships = []
    
    pt_projects.each do |pt_project|
      memberships += pt_project.memberships.all
    end
    
    recipients_with_name = []
    memberships.each do |membership|
      recipients_with_name << "#{membership.name} <#{
        membership.email}>" if report_receiver_ids.include?(membership.id)      
    end
    recipients_with_name
  end
  
  
  def init_pt_client
    @init_client ||= begin
      if pt_account.api_token.empty?
        PivotalTracker::Client.token(pt_account.email, pt_account.password)
      else
        PivotalTracker::Client.token = pt_account.api_token
      end      
    end
  end
  private :init_pt_client
  
  # a daily email digest with the stories that were started, finished,
  # delivered and discussed the previous day.
  def generate_daily_project_reports
    init_pt_client
    last_updated_at = updated_at
    self.touch

    projects = PivotalTracker::Project.all
    daily_project_reports = {:recipients => get_recipients(projects)}
    projects.each do |project|
      daily_project_reports[project.name] = generate_project_report(project, last_updated_at)
    end    
    daily_project_reports
  end
  
  
  def generate_daily_project_report(project, last_updated_at)
    daily_project_report = {:project => project}
    
    started_stories = daily_project_report[:started_stories] = []
    finished_stories = daily_project_report[:finished_stories] = []
    delivered_stories = daily_project_report[:delivered_stories] = []
    modified_stories = daily_project_report[:modified_stories] = []
    
    stories = project.stories.all(
      :modified_since => last_updated_at.strftime('%m/%d/%Y'))
    
    stories.each do |story|
      next unless story.updated_at > last_updated_at

      case story.current_state
      when /started/i
        started_stories << story
      when /finished/i
        finished_stories << story
      when /delivered/i
        delivered_stories << story
      else
        modified_stories << story
      end
    end    
    daily_project_report
  end
  private :generate_daily_project_report
  
end
