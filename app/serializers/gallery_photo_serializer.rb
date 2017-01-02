class GalleryPhotoSerializer < ActiveModel::Serializer
      # require 'null_attribute_remover'
      # include NullAttributesRemover 

            attributes :id,:name,:description,:gallery_id,:avatar      

      # def attributes
      #   check_null_attribute(super, [:id,:firstname, :lastname, :email,:authentication_token])
      # end
end
