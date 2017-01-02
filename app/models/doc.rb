# == Schema Information
#
# Table name: docs
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_docs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_b979a2ca95  (user_id => users.id)
#

class Doc < ActiveRecord::Base
	  has_many :project_docs
    has_many :projects, :through=> :project_docs
end
