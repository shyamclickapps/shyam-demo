# == Schema Information
#
# Table name: portfolios
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  projectarea         :string
#  start_date          :date
#  end_date            :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'elasticsearch/model'
class Portfolio < ActiveRecord::Base
       include Elasticsearch::Model
       include Elasticsearch::Model::Callbacks

       
	
   has_attached_file :avatar,  styles: { small: "100x100", med: "500x320", large: "1440x700" }, :default_url => "/assets/profile.png"
   do_not_validate_attachment_file_type :avatar	
end
