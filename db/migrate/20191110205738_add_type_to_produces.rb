class AddTypeToProduces < ActiveRecord::Migration[5.1]
  def change
    add_column :produces, :type, :string
  end
end
