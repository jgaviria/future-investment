class AddPhoneNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :phone_number, :string
  end
end
