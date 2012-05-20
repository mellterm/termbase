class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.integer :translation_id
      t.integer :associate_id
      t.timestamps
    end
  end
end
