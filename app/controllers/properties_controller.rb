require 'uri'
require 'nokogiri'

class PropertiesController < ApplicationController
  attr_reader :address

  before_action :set_property, only: [:show, :edit, :update, :destroy, :archive, :activate]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.where(archive: false).order(urgent: :desc).order(auction_date: :asc)

    respond_to do |format|
      format.html
      format.csv { send_data @properties.to_csv, filename: "property-list-#{Date.today}.csv" }
    end

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
  def new()
    @address      = params["address"]
    @city         = params["city"]
    @state        = params["state"]
    @zipcode      = params["zipcode"]
    @usecode      = params["usecode"]
    @property_sqr = params["property_sqr"]
    @home_sqr     = params["home_sqr"]
    @bathrooms    = params["bathrooms"]
    @bedrooms     = params["bedrooms"]
    @amount       = params["amount"]

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

  def call_zillow
    address        = URI.encode(params["property"]["address"])
    city_state_zip = "#{params["property"]["city"]}%2C#{params["property"]["state"]}"
    url            = "http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz17kwbh7pc7f_1oefy&address=#{address}&citystatezip=#{city_state_zip}"
    zillow_string  = HTTP.get(url).to_s
    doc            = Nokogiri::XML(zillow_string)
    response_code  = doc.at_xpath('//code').content

    if response_code == '0'
      @address      = doc.at_xpath('//response//results//result//address//street')&.content
      @city         = doc.at_xpath('//response//results//result//address//city')&.content
      @state        = doc.at_xpath('//response//results//result//address//state')&.content
      @zipcode      = doc.at_xpath('//response//results//result//address//zipcode')&.content
      @usecode      = doc.at_xpath('//response//results//result//useCode')&.content
      @property_sqr = doc.at_xpath('//response//results//result//lotSizeSqFt')&.content
      @home_sqr     = doc.at_xpath('//response//results//result//finishedSqFt')&.content
      @bathrooms    = doc.at_xpath('//response//results//result//bathrooms')&.content
      @bedrooms     = doc.at_xpath('//response//results//result//bedrooms')&.content
      @amount       = doc.at_xpath('//response//results//result//zestimate//amount')&.content
    end

    redirect_to new_property_path(address:  @address, city: @city,
                                  state:    @state, zipcode: @zipcode,
                                  usecode:  @usecode, property_sqr: @property_sqr,
                                  home_sqr: @home_sqr, bathrooms: @bathrooms,
                                  bedrooms: @bedrooms, amount: @amount)
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
    debts   = params["debts_attributes"].nil? ? [] : params["debts_attributes"]
    arv     = params["arv"].to_i
    act_amt = params["auction_amount"].to_i
    adder   = 0
    debts.each do |hash|
      adder += hash.second["value"].to_i
    end
    arv - (adder + act_amt)
  end

  def show_csv
    csv = []
    csv << ["id", "address", "county"]
    Property.all.each do |p|
      csv << [p.id, p.address, p.county]
    end
  end

end

