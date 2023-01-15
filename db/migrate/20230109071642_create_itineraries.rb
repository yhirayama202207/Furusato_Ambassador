class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :comment
      t.integer :rate, default: 0
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
