class CreateJapanPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :japan_prefectures do |t|

      t.timestamps
    end
  end
end
