class AddDocumentIdToTranslations < ActiveRecord::Migration
  def change
    add_column :translations, :document_id, :integer

  end
end
