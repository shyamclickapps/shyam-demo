# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  follower_id  :integer
#  following_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_follows_on_follower_id   (follower_id)
#  index_follows_on_following_id  (following_id)
#

class Follow < ActiveRecord::Base
   belongs_to :follower, class_name: "User"
	 belongs_to :following, class_name: "User"
end
