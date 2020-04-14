class AddArchivedBy < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :archived_by, :string
  end
end
