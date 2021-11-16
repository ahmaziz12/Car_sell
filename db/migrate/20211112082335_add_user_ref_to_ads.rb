class AddUserRefToAds < ActiveRecord::Migration[6.1]
  def change
     add_reference :ads, :user
  end
end
