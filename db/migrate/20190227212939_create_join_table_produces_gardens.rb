class CreateJoinTableProducesGardens < ActiveRecord::Migration[5.1]
  def change
    create_join_table :gardens, :produces do |t|
      t.index [:garden_id, :produce_id]
      t.index [:produce_id, :garden_id]
    end
  end
end
