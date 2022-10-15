class CreateJapanAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :japan_areas do |t|

      t.timestamps
    end
  end
end
