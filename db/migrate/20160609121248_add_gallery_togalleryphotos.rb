class AddGalleryTogalleryphotos < ActiveRecord::Migration
  def change
  	   add_reference :gallery_photos, :galleries, index: true
  end
end
