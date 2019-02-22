class CreateGardenProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :garden_produces do |t|
      t.string :prediction_date
      t.integer :readiness

      t.timestamps
    end
  end
end
