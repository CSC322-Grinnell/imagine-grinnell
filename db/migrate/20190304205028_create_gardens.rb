class CreateGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :gardens do |t|
      t.string :garden_name
      t.string :address
      t.string :contact_name
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
