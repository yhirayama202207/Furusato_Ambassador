class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.integer :article_id
      t.integer :comment_id
      t.string :action, default: "", null: false
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :sender_id
    add_index :notifications, :receiver_id
    add_index :notifications, :article_id
    add_index :notifications, :comment_id
  end
end
