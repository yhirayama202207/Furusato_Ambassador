class CreateJapanAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :japan_areas do |t|
      t.string :name, null: false
      t.string :name_english, null: false

      t.timestamps null: false
    end
  end
end
