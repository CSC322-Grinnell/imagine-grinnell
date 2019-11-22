class CreateVolunteers < ActiveRecord::Migration[5.1]
  def change
    create_table :volunteers do |t|
      t.string :email
      t.string :password
      t.string :salt

      t.timestamps
    end
    add_index :volunteers, :email, unique: true
  end
end
