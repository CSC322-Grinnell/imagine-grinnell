class CreateProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :produces do |t|
      t.string :name
      t.integer :duration
      t.date :start_date
      t.date :end_date
      t.string :image
      t.string :type

      t.timestamps
    end
  end
end
