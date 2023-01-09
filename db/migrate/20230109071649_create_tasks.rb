class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :itinerary_id, null: false
      t.integer :user_id, null: false
      t.string :task, null: false
      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
      t.text :memo
      t.string :way
      t.string :spot
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :price, null: false, default: 0
      t.integer :rate, default: 0

      t.timestamps
    end
  end
end
