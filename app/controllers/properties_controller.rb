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
    @nickname = User.find(@property.created_by).nickname
  end

  # GET /properties/new
  def new()
    @property = Property.new
    @nickname = current_user.id
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

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
    params.require(:property).permit(:address, :city, :notes,  :urgent, :archive, :property, :created_by, :members_attributes => [:id, :name, :occupation, :identification, :age])
  end

  def show_csv
    csv = []
    csv << ["id", "address", "county"]
    Property.all.each do |p|
      csv << [p.id, p.address, p.county]
    end
  end

end

