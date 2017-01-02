class GallerySerializer < ActiveModel::Serializer
      # require 'null_attribute_remover'
      # include NullAttributesRemover 

      attributes :id,:name,:description,:avatar      

      # def attributes
      #   check_null_attribute(super, [:id,:firstname, :lastname, :email,:authentication_token])
      # end
end
