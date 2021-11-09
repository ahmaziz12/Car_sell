class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|

      t.belongs_to :ad
      t.timestamps
    end
  end
end
