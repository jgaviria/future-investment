class CreateDebts < ActiveRecord::Migration[5.2]
  def change
    create_table :debts do |t|
      t.string :kind
      t.integer :value
      t.integer :property_id

      t.timestamps
    end
  end
end
