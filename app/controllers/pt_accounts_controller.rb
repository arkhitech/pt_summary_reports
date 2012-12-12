class PtAccountsController < ApplicationController
  # GET /pt_accounts
  # GET /pt_accounts.json
  def index
    @pt_accounts = PtAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pt_accounts }
    end
  end

  # GET /pt_accounts/1
  # GET /pt_accounts/1.json
  def show
    @pt_account = PtAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pt_account }
    end
  end

  # GET /pt_accounts/new
  # GET /pt_accounts/new.json
  def new
    @pt_account = PtAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pt_account }
    end
  end

  # GET /pt_accounts/1/edit
  def edit
    @pt_account = PtAccount.find(params[:id])
  end

  # POST /pt_accounts
  # POST /pt_accounts.json
  def create
    @pt_account = PtAccount.new(params[:pt_account])

    respond_to do |format|
      if @pt_account.save
        format.html { redirect_to @pt_account, notice: 'Pt account was successfully created.' }
        format.json { render json: @pt_account, status: :created, location: @pt_account }
      else
        format.html { render action: "new" }
        format.json { render json: @pt_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pt_accounts/1
  # PUT /pt_accounts/1.json
  def update
    @pt_account = PtAccount.find(params[:id])

    respond_to do |format|
      if @pt_account.update_attributes(params[:pt_account])
        format.html { redirect_to @pt_account, notice: 'Pt account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pt_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pt_accounts/1
  # DELETE /pt_accounts/1.json
  def destroy
    @pt_account = PtAccount.find(params[:id])
    @pt_account.destroy

    respond_to do |format|
      format.html { redirect_to pt_accounts_url }
      format.json { head :no_content }
    end
  end
end
