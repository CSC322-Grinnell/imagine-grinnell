class CreateGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.string :contact_name
      t.string :contact_number
      t.string :email

      t.timestamps
    end
  end
end
