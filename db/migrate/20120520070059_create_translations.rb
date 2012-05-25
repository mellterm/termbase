class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :source_language_id
      t.string :source_content
      t.integer :target_language_id
      t.string :target_content
      t.integer :version
      t.string :type
      t.integer :created_by_id
      t.integer :group_id
      t.text :metadata
      t.string :ilk, :default => 'Term'
      t.timestamps
    end
    add_index :translations, :source_content
    Translation.create_versioned_table
  end
  
  def self.down
    drop_table :translations
    Translation.drop_versioned_table
  end
  
end