class CreateGardens < ActiveRecord::Migration
  def change
    create_table :gardens do |t|

      t.timestamps null: false
    end
  end
end
