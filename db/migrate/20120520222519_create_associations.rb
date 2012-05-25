class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.integer :associator_id
      t.integer :associated_id
      t.timestamps
    end

  add_index :associations, :associator_id
  add_index :associations, :associated_id
  add_index :associations, [:associator_id, :associated_id], :unique => true
  end
end
