class CreateProduces < ActiveRecord::Migration
  def change
    create_table :produces do |t|

      t.timestamps null: false
    end
  end
end
