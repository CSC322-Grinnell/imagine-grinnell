class CreateProduces < ActiveRecord::Migration
  def change
    create_table :produces do |t|
      t.string :name
      t.string :availability_prediction
      t.integer :readiness

      t.timestamps null: false
    end
  end
end
