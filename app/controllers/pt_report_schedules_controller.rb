class PtReportSchedulesController < ApplicationController
  before_filter :authenticate_user!

  # GET /pt_report_schedules/1/edit
  def edit
    @pt_report_schedule = authorized_pt_report_schedule
  end

  def authorized_pt_report_schedule
    if(params[:pt_account_id])
      @pt_account = current_user.pt_account.find(params[:pt_account_id])
      @pt_report_schedule = @pt_account.pt_report_schedules.find(params[:id])
    else
      @pt_report_schedule = PtReportSchedule.find(params[:id])
      if @pt_report_schedule && @pt_report_schedule.pt_account.user == current_user.id
        @pt_report_schedule
      else
        nil
      end
    end    
  end
  private :authorized_pt_report_schedule
  
  # POST /pt_report_schedules
  # POST /pt_report_schedules.json
  def create
    @pt_account = current_user.pt_account.find(params[:pt_account_id])
    @pt_report_schedule = @pt_account.pt_report_schedules.new(params[:pt_report_schedule])

    respond_to do |format|
      if @pt_report_schedule.save
        format.html { redirect_to @pt_report_schedule, notice: 'Pt report schedule was successfully created.' }
        format.json { render json: @pt_report_schedule, status: :created, location: @pt_report_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @pt_report_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pt_report_schedules/1
  # PUT /pt_report_schedules/1.json
  def update
    @pt_report_schedule = authorized_pt_report_schedule

    respond_to do |format|
      if @pt_report_schedule.nil?
        format.html { redirect_to current_user, notice: 'Invalid Report Schedule' }
        format.json { render json: {error: 'Invalid Report Schedule'}, status: :unprocessable_entity }
      elsif @pt_report_schedule.update_attributes(params[:pt_report_schedule])
        format.html { redirect_to @pt_report_schedule, notice: 'Pt report schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pt_report_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pt_report_schedule = authorized_pt_report_schedule
    if @pt_report_schedule
      @pt_report_schedule.destroy 
      redirect_to pt_account_path(@pt_account)
    else
      redirect_to current_user, notice: 'Invalid Report Schedule'
    end
  end
  
end
