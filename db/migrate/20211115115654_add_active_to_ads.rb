class AddActiveToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :closed, :boolean
  end
end
