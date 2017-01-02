class UserSerializer < ActiveModel::Serializer
  # require 'null_attribute_remover'
  # include NullAttributesRemover

  attributes :id,:firstname,:lastname,:email,:authentication_token,:user_type

  # def attributes
  #   check_null_attribute(super, [:id,:firstname, :lastname, :email,:authentication_token])
  # end
end
