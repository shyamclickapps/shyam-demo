# == Schema Information
#
# Table name: phone_numbers
#
#  id         :integer          not null, primary key
#  number     :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PhoneNumber < ActiveRecord::Base
	 belongs_to :user
end
