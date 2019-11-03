class CreateGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.string :contact_name_1
      t.string :contact_number_1
      t.string :email_1
      t.string :contact_name_2
      t.string :contact_number_2
      t.string :email_2
      t.string :image

      t.timestamps
    end
  end
end
