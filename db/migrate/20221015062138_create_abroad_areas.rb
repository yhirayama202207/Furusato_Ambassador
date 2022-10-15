class CreateAbroadAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :abroad_areas do |t|

      t.timestamps
    end
  end
end
