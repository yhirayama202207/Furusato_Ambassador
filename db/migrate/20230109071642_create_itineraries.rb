class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.text :comment
      t.integer :rate, default: 0
      t.integer :total_payment, null: false, default: 0
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
