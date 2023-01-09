class CreateBelongings < ActiveRecord::Migration[6.1]
  def change
    create_table :belongings do |t|
      t.integer "user_id", null: false
      t.string :name

      t.timestamps
    end
  end
end
