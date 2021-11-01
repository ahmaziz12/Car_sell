class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|

  t.string :city
  t.float :milage
  t.string :make
  t.float :price
  t.string :engine_type
  t.string :transmission
  t.float :capacity
  t.string :color
  t.string :assembly
  t.text :description
  t.string :secondary_contact
  t.boolean :featured


      t.timestamps
    end
  end
end
