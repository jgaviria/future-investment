class AddAuctionFields < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :auction_type, :string
    add_column :properties, :auction_date, :datetime
  end
end
