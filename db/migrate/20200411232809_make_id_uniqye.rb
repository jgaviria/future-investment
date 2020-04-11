class MakeIdUniqye < ActiveRecord::Migration[5.2]
  def change
    add_index :members, :identification, :unique => true
  end
end
