class CreateProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :produces do |t|
      t.string :name
      t.string :prediction_date
      t.integer :readiness

      t.timestamps
    end
  end
end
