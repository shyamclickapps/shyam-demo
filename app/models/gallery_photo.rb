# == Schema Information
#
# Table name: gallery_photos
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  gallery_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  galleries_id        :integer
#
# Indexes
#
#  index_gallery_photos_on_galleries_id  (galleries_id)
#

class GalleryPhoto < ActiveRecord::Base
	belongs_to :galleries
	has_attached_file :avatar,  styles: { small: "100x100", med: "500x320", large: "1440x700" }, :default_url => "/assets/profile.png"
  do_not_validate_attachment_file_type :avatar

end
