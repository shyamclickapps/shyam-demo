class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
		    	 t.string :name
		       t.string :description
		       t.integer :gallery_id, references: :galleries

      t.timestamps null: false
    end
  end
end
