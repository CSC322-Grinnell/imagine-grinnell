class CreateProduces < ActiveRecord::Migration[5.1]
  def change
    create_table :produces do |t|
      t.string :name
      t.string :duration
      t.string :image

      t.timestamps
    end
  end
end
