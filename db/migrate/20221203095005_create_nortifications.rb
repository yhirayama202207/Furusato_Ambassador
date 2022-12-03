class CreateNortifications < ActiveRecord::Migration[6.1]
  def change
    create_table :nortifications do |t|

      t.timestamps
    end
  end
end
