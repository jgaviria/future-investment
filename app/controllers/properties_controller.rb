class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy, :archive, :activate]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.where(archive: false).order(urgent: :desc).order(auction_date: :asc)
  end

  # GET /properties
  # GET /properties.json
  def archives
    @archived_properties = Property.where(archive: true)
  end

  # GET /properties
  # GET /properties.json
  def archive
    if @property.update(archive: true)
      redirect_to properties_path, notice: 'Property was successfully archived.'
    else
      raise 'damn something happened'
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property        = Property.new(property_params)
    @property.profit = calculate_profit(params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    @property.profit = calculate_profit(property_params)
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Moves properties back to an active state
  def activate
    if @property.update(archive: false)
      redirect_to properties_path, notice: 'Activated'
    else
      raise 'damn something happened'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def property_params
    params.require(:property).permit(:address, :city, :state, :zip_code, :county, :owner_name, :auction_amount, :arv, :property_type, :number_of_bedrooms, :number_of_bathrooms, :home_sqr_footage, :property_sqr_footage, :found_by, :secondary_revision, :type_of_loan, :home_status, :notes, :agent, :review_by_date, :urgent, :possible_phone_numbers, :possible_address, :archive, :auction_type, :auction_date, :profit, :property, :debts_attributes => [:id, :kind, :value])
  end

  def calculate_profit(params)
    debts =  params["debts_attributes"].nil? ? [] : params["debts_attributes"]
    arv     = params["arv"].to_i
    act_amt = params["auction_amount"].to_i
    adder   = 0
    debts.each do |hash|
      adder += hash.second["value"].to_i
    end
    arv - (adder + act_amt)
  end
end
