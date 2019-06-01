class Property < ApplicationRecord
  has_many :debts
  accepts_nested_attributes_for :debts

  attr_accessor :p_profit

  has_many_attached :property
end
