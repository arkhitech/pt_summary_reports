class PtReportReceiversController < ApplicationController
  before_filter :authenticate_user!

  def authorized_pt_report_receiver
    @pt_report_receiver = PtReportReceiver.find(params[:id])
    
    if @pt_report_receiver && 
      (@pt_report_receiver.pt_report_schedule.pt_account.user_id == current_user.id)
      @pt_report_receiver
    end
  end
  private :authorized_pt_report_receiver
  
  def destroy
    @pt_report_receiver = authorized_pt_report_receiver
    if @pt_report_receiver
      @pt_report_receiver.destroy
      redirect_to :back
    else
      redirect_to user_pt_accounts_path(current_user), notice: 'Invalid Report Receiver'
    end
  end
end
