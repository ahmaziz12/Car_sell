class ChangeIndexesInUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :email
    add_index :users, :email,                unique: false
    remove_index :users, :phone
    add_index :users, :phone,                unique: false
  end
end
