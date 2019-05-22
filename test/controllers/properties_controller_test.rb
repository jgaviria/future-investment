require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get properties_url
    assert_response :success
  end

  test "should get new" do
    get new_property_url
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post properties_url, params: { property: { address: @property.address, agent: @property.agent, arv: @property.arv, auction_amount: @property.auction_amount, city: @property.city, county: @property.county, found_by: @property.found_by, home_sqr_footage: @property.home_sqr_footage, home_status: @property.home_status, notes: @property.notes, number_of_bathrooms: @property.number_of_bathrooms, number_of_bedrooms: @property.number_of_bedrooms, owner_name: @property.owner_name, possible_address: @property.possible_address, possible_phone_numbers: @property.possible_phone_numbers, property_sqr_footage: @property.property_sqr_footage, property_type: @property.property_type, review_by_date: @property.review_by_date, secondary_revision: @property.secondary_revision, state: @property.state, type_of_loan: @property.type_of_loan, urgent: @property.urgent, zip_code: @property.zip_code } }
    end

    assert_redirected_to property_url(Property.last)
  end

  test "should show property" do
    get property_url(@property)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_url(@property)
    assert_response :success
  end

  test "should update property" do
    patch property_url(@property), params: { property: { address: @property.address, agent: @property.agent, arv: @property.arv, auction_amount: @property.auction_amount, city: @property.city, county: @property.county, found_by: @property.found_by, home_sqr_footage: @property.home_sqr_footage, home_status: @property.home_status, notes: @property.notes, number_of_bathrooms: @property.number_of_bathrooms, number_of_bedrooms: @property.number_of_bedrooms, owner_name: @property.owner_name, possible_address: @property.possible_address, possible_phone_numbers: @property.possible_phone_numbers, property_sqr_footage: @property.property_sqr_footage, property_type: @property.property_type, review_by_date: @property.review_by_date, secondary_revision: @property.secondary_revision, state: @property.state, type_of_loan: @property.type_of_loan, urgent: @property.urgent, zip_code: @property.zip_code } }
    assert_redirected_to property_url(@property)
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete property_url(@property)
    end

    assert_redirected_to properties_url
  end
end
