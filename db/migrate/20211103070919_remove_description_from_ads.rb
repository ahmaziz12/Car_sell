class RemoveDescriptionFromAds < ActiveRecord::Migration[6.1]
  def change
    remove_column :ads, :description, :text
  end
end
