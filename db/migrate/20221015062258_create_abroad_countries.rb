class CreateAbroadCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :abroad_countries do |t|

      t.timestamps
    end
  end
end
