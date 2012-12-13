class PtReportReceiversController < ApplicationController
  before_filter :authenticate_user!
  # GET /pt_report_receivers
  # GET /pt_report_receivers.json
  def index
    @pt_report_receivers = PtReportReceiver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pt_report_receivers }
    end
  end

  # GET /pt_report_receivers/1
  # GET /pt_report_receivers/1.json
  def show
    @pt_report_receiver = PtReportReceiver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pt_report_receiver }
    end
  end

  # GET /pt_report_receivers/new
  # GET /pt_report_receivers/new.json
  def new
    @pt_report_receiver = PtReportReceiver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pt_report_receiver }
    end
  end

  # GET /pt_report_receivers/1/edit
  def edit
    @pt_report_receiver = PtReportReceiver.find(params[:id])
  end

  # POST /pt_report_receivers
  # POST /pt_report_receivers.json
  def create
    @pt_report_receiver = PtReportReceiver.new(params[:pt_report_receiver])

    respond_to do |format|
      if @pt_report_receiver.save
        format.html { redirect_to @pt_report_receiver, notice: 'Pt report receiver was successfully created.' }
        format.json { render json: @pt_report_receiver, status: :created, location: @pt_report_receiver }
      else
        format.html { render action: "new" }
        format.json { render json: @pt_report_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pt_report_receivers/1
  # PUT /pt_report_receivers/1.json
  def update
    @pt_report_receiver = PtReportReceiver.find(params[:id])

    respond_to do |format|
      if @pt_report_receiver.update_attributes(params[:pt_report_receiver])
        format.html { redirect_to @pt_report_receiver, notice: 'Pt report receiver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pt_report_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pt_report_receivers/1
  # DELETE /pt_report_receivers/1.json
  def destroy
    @pt_report_receiver = PtReportReceiver.find(params[:id])
    @pt_report_receiver.destroy

    respond_to do |format|
      format.html { redirect_to pt_report_receivers_url }
      format.json { head :no_content }
    end
  end
end
