class AddSourceLanguageToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :source_language_id, :integer
  end
end
