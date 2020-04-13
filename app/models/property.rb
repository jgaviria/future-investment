require 'csv'

class Property < ApplicationRecord
  has_many :members
  accepts_nested_attributes_for :members
  attr_accessor :p_profit
  has_many_attached :property

  def self.to_csv
    attributes_property = %w{id address city notes}
    attributes_member   = %w{name phone_number}
    headers             = attributes_property + attributes_member
    CSV.generate(headers: true) do |csv|
      csv << headers

      Property.order(:city).each do |property|
        a =  attributes_property.map { |attr| property.send(attr) }
        b = attributes_member.map { |attr| property&.members&.first&.send(attr)}

        csv << a + b
      end
    end
  end
end
