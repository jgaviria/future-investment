class RenameDebtFields < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string  :name
      t.string  :occupation
      t.string  :identification
      t.integer :age
      t.integer :property_id

      t.timestamps
    end
  end
end
