class AddProfitField < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :profit, :integer
  end
end
