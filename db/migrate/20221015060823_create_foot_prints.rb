class CreateFootPrints < ActiveRecord::Migration[6.1]
  def change
    create_table :foot_prints do |t|

      t.timestamps
    end
  end
end
