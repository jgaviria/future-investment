require 'csv'

class Property < ApplicationRecord
  has_many :members
  accepts_nested_attributes_for :members
  attr_accessor :p_profit
  has_many_attached :property

  def self.to_csv
    attributes = %w{id auction_date county address owner_name property_type number_of_bedrooms number_of_bathrooms home_sqr_footage auction_amount arv notes}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
