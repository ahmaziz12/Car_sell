class ChangeDataTypeOfPhoneInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :phone, :string
  end
  
  def down
    change_column :users, :phone, :bigint
  end
end
