require 'uri'
require 'nokogiri'

class PropertiesController < ApplicationController
  attr_reader :address

  before_action :set_property, only: [:show, :edit, :update, :destroy, :archive, :activate]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.where(archive: false).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data @properties.to_csv, filename: "property-list-#{Date.today}.csv" }
    end

  end

  # GET /properties
  # GET /properties.json
  def archives
    @archived_properties = Property.where(archive: true).order(updated_at: :desc)
  end

  # GET /properties
  # GET /properties.json
  def archive
    user = User.find(current_user.id)
    return unless user
    if @property.update(archive: true, archived_by: user.nickname)
      redirect_to properties_path, notice: 'Property was successfully archived.'
    else
      raise 'damn something happened'
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    property = Property.find(params["id"])
    id = property&.created_by
    @nickname = User.find(id)&.nickname
  end

  # GET /properties/new
  def new()
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.created_by = current_user&.id
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

  # Moves properties back to an active state
  def maps
    @properties = Property.where(archive: false)
    @hash = Gmaps4rails.build_markers(@properties) do |user, marker|
      marker.lat user&.latitude
      marker.lng user&.longitude + user.id.to_f / 100000
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def property_params
    params.require(:property).permit(:address, :city, :notes,  :urgent, :archive, :property, :created_by, :members_attributes => [:id, :name, :occupation, :identification, :age, :phone_number])
  end

end

