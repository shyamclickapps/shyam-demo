class AddAttachmentAvatarToGalleryPhotos < ActiveRecord::Migration
  def self.up
    change_table :gallery_photos do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :gallery_photos, :avatar
  end
end
