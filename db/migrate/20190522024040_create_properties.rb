class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :county
      t.string :owner_name
      t.integer :auction_amount
      t.integer :arv
      t.string :property_type
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.integer :home_sqr_footage
      t.integer :property_sqr_footage
      t.string :found_by
      t.string :secondary_revision
      t.string :type_of_loan
      t.string :home_status
      t.string :notes
      t.string :agent
      t.date :review_by_date
      t.boolean :urgent
      t.string :possible_phone_numbers
      t.string :possible_address

      t.timestamps
    end
  end
end
