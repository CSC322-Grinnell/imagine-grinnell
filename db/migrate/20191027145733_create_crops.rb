class CreateCrops < ActiveRecord::Migration[5.1]
  def change
    create_table :crops do |t|
      t.integer :produce
      t.integer :garden_id
      t.string :planted_at
      t.text :description

      t.timestamps
    end
  end
end
