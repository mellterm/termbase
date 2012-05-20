class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :source_language_id
      t.string :source_content
      t.integer :target_language_id
      t.string :target_content
      t.integer :version
      t.string :type
      t.integer :authority_id
      t.text :metadata
      t.timestamps
    end
    add_index :translations, :source_content
  end
end
