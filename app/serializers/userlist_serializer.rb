class UserlistSerializer < ActiveModel::Serializer
  attributes :id,:firstname,:lastname,:email,:authentication_token,:user_type
end
