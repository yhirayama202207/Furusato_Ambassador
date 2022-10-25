class CreateCheerRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :cheer_regions do |t|

      t.timestamps
    end
  end
end
