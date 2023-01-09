class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer "user_id", null: false
      t.integer "japan_prefecture_id", null: false
      t.string :region
      t.string :name
      t.string :title, null: false
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :body, null: false
      t.float :rate, default: 0
      t.boolean :is_active, null: false, default: true

      t.timestamps null: false
    end
  end
end
