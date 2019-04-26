class CreateGardenProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :garden_produces do |t|
      t.integer :garden_id
      t.integer :produce_id
      t.string :available_at
      t.integer :readiness
      t.string :planted_at

      t.timestamps
    end
  end
end
