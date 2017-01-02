# == Schema Information
#
# Table name: galleries
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  user_id             :integer
#

class Gallery < ActiveRecord::Base
	has_many :gallery_photos,:dependent=>:destroy
  belongs_to :user
	
	has_attached_file :avatar,  styles: { small: "100x100", med: "500x320", large: "1440x700" }, :default_url => "/assets/profile.png"
  do_not_validate_attachment_file_type :avatar	   
end
