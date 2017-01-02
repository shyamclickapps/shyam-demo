class AddAttachmentAvatarToGalleries < ActiveRecord::Migration
  def self.up
    change_table :galleries do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :galleries, :avatar
  end
end
