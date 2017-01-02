# == Schema Information
#
# Table name: projects
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
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_b872a6760a  (user_id => users.id)
#

class Project < ActiveRecord::Base
		belongs_to :user
	  has_many  :project_docs
    has_many  :docs, :through => :project_docs
end
