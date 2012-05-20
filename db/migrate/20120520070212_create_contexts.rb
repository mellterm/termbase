class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.integer :translation_id
      t.integer :domain_id

      t.timestamps
    end
  end
end
