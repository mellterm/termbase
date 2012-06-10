class AddDocumentIdToDomains < ActiveRecord::Migration
  def change
    add_column :domains, :document_id, :integer
  end
end
