class ProjectSerializer < ActiveModel::Serializer

  attributes :user_id, :name, :description, :docs

  def docs
      DocSerializer.new(object) 
  end 	

end
