class CreateProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :produces do |t|
      t.string :name
      t.integer :readiness
      t.string :prediction_date

      t.timestamps
    end
  end
end
