# == Schema Information
#
# Table name: pt_report_schedules
#
#  id            :integer          not null, primary key
#  pt_account_id :integer
#  report_time   :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PtReportSchedule < ActiveRecord::Base
  belongs_to :pt_account, inverse_of: :pt_report_schedules
  has_many :pt_report_receivers, dependent: :destroy, inverse_of: :pt_report_schedule

  attr_accessible :report_time, :pt_report_receivers_attributes

  accepts_nested_attributes_for :pt_report_receivers, 
    reject_if: proc { |attrs| attrs.all? { |k, v| v.blank? } }

  class << self

    # The frequency at which the scheduler runs. Used to avoid sending
    # duplicate reports
    def send_daily_report
      report_time = Time.now

      pt_report_schedules = 
        PtReportSchedule.where('TIME(report_time) <= TIME(?) AND (updated_at <= ? OR updated_at = created_at)', 
        report_time, report_time.beginning_of_day).includes([:pt_report_receivers, :pt_account])

      PtReportSchedule.transaction do
        pt_report_schedules.each do |pt_report_schedule|
          pt_report_schedule.send_daily_report if pt_report_schedule.pt_report_receivers.any?
        end
      end
    end    
  end

  def prune_pt_report_receivers(params)
    receiver_attributes = params[:pt_report_receivers_attributes]
    
    if receiver_attributes.nil?
      #just remove all receivers and exit
      self.pt_report_receivers.destroy_all
      return
    end
    
    pt_membership_ids = receiver_attributes.collect {
      |report_receiver| report_receiver[:pt_membership_id].to_i}
    
    #remove pt_membership_ids not included
    self.pt_report_receivers.
      select(:pt_membership_id).where('pt_membership_id NOT IN (?)', 
      pt_membership_ids).destroy_all
    
    intersecting_pt_membership_ids = self.pt_report_receivers.
      select(:pt_membership_id).where(pt_membership_id: pt_membership_ids).
      collect {|report_receiver| report_receiver.pt_membership_id}
 
    unless intersecting_pt_membership_ids.empty?
      to_be_added_pt_membership_ids = pt_membership_ids - intersecting_pt_membership_ids

      params[:pt_report_receivers_attributes] = []
      to_be_added_pt_membership_ids.each do |pt_membership_id|
        params[:pt_report_receivers_attributes] << {pt_membership_id: pt_membership_id}
      end
    end    
  end
  private :prune_pt_report_receivers
  
  def update_attributes_custom(params)
    prune_pt_report_receivers(params)
    update_attributes(params)
  end
  
  def send_daily_report
    daily_project_reports = generate_daily_project_reports
    PtReportMailer.daily_report(daily_project_reports).deliver if daily_project_reports
  end

  def get_recipients(pt_projects)
    report_receivers = pt_report_receivers 
    
    #create a set from report receiver to quickly match email addresses (n+n)
    report_receiver_ids = Set.new
    report_receivers.each do |report_receiver|
      report_receiver_ids << report_receiver.pt_membership_id
    end
    
    pt_account.init_pt_client
    pt_memberships = available_pt_memberships(pt_projects)
    recipients_with_name = []
    pt_memberships.each do |pt_membership|
      recipients_with_name << "#{pt_membership.name} <#{
        pt_membership.email}>" if report_receiver_ids.include?(pt_membership.id)      
    end
    recipients_with_name
  end
    
  def available_pt_memberships(pt_projects = nil)
    pt_projects ||= begin
      return [] unless pt_account.init_pt_client
      PivotalTracker::Project.all
    end
    pt_memberships = []
    
    pt_projects.each do |pt_project|
      pt_memberships += pt_project.memberships.all
    end
    pt_memberships
  end
  
  def pt_report_receiver?(pt_membership)
    pt_report_receivers.find_by_pt_membership_id(pt_membership.id)
  end
  # a daily email digest with the stories that were started, finished,
  # delivered and discussed the previous day.
  def generate_daily_project_reports
    last_updated_at = updated_at
    unless pt_account.init_pt_client
      PtReportMailer.credentials_mismatch_notification(self).deliver
      self.touch
      return nil
    end
    self.touch

    projects = PivotalTracker::Project.all
    daily_project_reports = {recipients: get_recipients(projects), projects: []}
    projects.each do |project|
      daily_project_reports[:projects] << generate_daily_project_report(project, last_updated_at)
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
