class CreateJapanPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :japan_prefectures do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
