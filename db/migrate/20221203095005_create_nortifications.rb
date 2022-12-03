class CreateNortifications < ActiveRecord::Migration[6.1]
  def change
    create_table :nortifications do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.integer :article_id
      t.integer :comment_id
      t.string :action, default: "", null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :nortifications, :sender_id
    add_index :nortifications, :receiver_id
    add_index :nortifications, :article_id
    add_index :nortifications, :comment_id
  end
end
