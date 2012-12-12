class PtReportSchedulesController < ApplicationController
  # GET /pt_report_schedules
  # GET /pt_report_schedules.json
  def index
    @pt_report_schedules = PtReportSchedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pt_report_schedules }
    end
  end

  # GET /pt_report_schedules/1
  # GET /pt_report_schedules/1.json
  def show
    @pt_report_schedule = PtReportSchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pt_report_schedule }
    end
  end

  # GET /pt_report_schedules/new
  # GET /pt_report_schedules/new.json
  def new
    @pt_report_schedule = PtReportSchedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pt_report_schedule }
    end
  end

  # GET /pt_report_schedules/1/edit
  def edit
    @pt_report_schedule = PtReportSchedule.find(params[:id])
  end

  # POST /pt_report_schedules
  # POST /pt_report_schedules.json
  def create
    @pt_report_schedule = PtReportSchedule.new(params[:pt_report_schedule])

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
    @pt_report_schedule = PtReportSchedule.find(params[:id])

    respond_to do |format|
      if @pt_report_schedule.update_attributes(params[:pt_report_schedule])
        format.html { redirect_to @pt_report_schedule, notice: 'Pt report schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pt_report_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pt_report_schedules/1
  # DELETE /pt_report_schedules/1.json
  def destroy
    @pt_report_schedule = PtReportSchedule.find(params[:id])
    @pt_report_schedule.destroy

    respond_to do |format|
      format.html { redirect_to pt_report_schedules_url }
      format.json { head :no_content }
    end
  end
end
