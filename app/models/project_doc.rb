# == Schema Information
#
# Table name: project_docs
#
#  id         :integer          not null, primary key
#  project_id :integer
#  doc_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_project_docs_on_doc_id      (doc_id)
#  index_project_docs_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_6269934a6e  (doc_id => docs.id)
#  fk_rails_90419a83f4  (project_id => projects.id)
#

class ProjectDoc < ActiveRecord::Base
	    belongs_to :project
	    belongs_to :doc
end
