class CreateProjectDocs < ActiveRecord::Migration
  def change
    create_table :project_docs do |t|
    	t.references :project, index: true, foreign_key: true
    	t.references :doc, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
