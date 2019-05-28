class AddArchiveField < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :archive, :boolean, default: false
  end
end
