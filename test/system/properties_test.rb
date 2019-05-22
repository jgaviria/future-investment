require "application_system_test_case"

class PropertiesTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one)
  end

  test "visiting the index" do
    visit properties_url
    assert_selector "h1", text: "Properties"
  end

  test "creating a Property" do
    visit properties_url
    click_on "New Property"

    fill_in "Address", with: @property.address
    fill_in "Agent", with: @property.agent
    fill_in "Arv", with: @property.arv
    fill_in "Auction amount", with: @property.auction_amount
    fill_in "City", with: @property.city
    fill_in "County", with: @property.county
    fill_in "Found by", with: @property.found_by
    fill_in "Home sqr footage", with: @property.home_sqr_footage
    fill_in "Home status", with: @property.home_status
    fill_in "Notes", with: @property.notes
    fill_in "Number of bathrooms", with: @property.number_of_bathrooms
    fill_in "Number of bedrooms", with: @property.number_of_bedrooms
    fill_in "Owner name", with: @property.owner_name
    fill_in "Possible address", with: @property.possible_address
    fill_in "Possible phone numbers", with: @property.possible_phone_numbers
    fill_in "Property sqr footage", with: @property.property_sqr_footage
    fill_in "Property type", with: @property.property_type
    fill_in "Review by date", with: @property.review_by_date
    fill_in "Secondary revision", with: @property.secondary_revision
    fill_in "State", with: @property.state
    fill_in "Type of loan", with: @property.type_of_loan
    check "Urgent" if @property.urgent
    fill_in "Zip code", with: @property.zip_code
    click_on "Create Property"

    assert_text "Property was successfully created"
    click_on "Back"
  end

  test "updating a Property" do
    visit properties_url
    click_on "Edit", match: :first

    fill_in "Address", with: @property.address
    fill_in "Agent", with: @property.agent
    fill_in "Arv", with: @property.arv
    fill_in "Auction amount", with: @property.auction_amount
    fill_in "City", with: @property.city
    fill_in "County", with: @property.county
    fill_in "Found by", with: @property.found_by
    fill_in "Home sqr footage", with: @property.home_sqr_footage
    fill_in "Home status", with: @property.home_status
    fill_in "Notes", with: @property.notes
    fill_in "Number of bathrooms", with: @property.number_of_bathrooms
    fill_in "Number of bedrooms", with: @property.number_of_bedrooms
    fill_in "Owner name", with: @property.owner_name
    fill_in "Possible address", with: @property.possible_address
    fill_in "Possible phone numbers", with: @property.possible_phone_numbers
    fill_in "Property sqr footage", with: @property.property_sqr_footage
    fill_in "Property type", with: @property.property_type
    fill_in "Review by date", with: @property.review_by_date
    fill_in "Secondary revision", with: @property.secondary_revision
    fill_in "State", with: @property.state
    fill_in "Type of loan", with: @property.type_of_loan
    check "Urgent" if @property.urgent
    fill_in "Zip code", with: @property.zip_code
    click_on "Update Property"

    assert_text "Property was successfully updated"
    click_on "Back"
  end

  test "destroying a Property" do
    visit properties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Property was successfully destroyed"
  end
end
