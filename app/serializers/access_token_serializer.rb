class AccessTokenSerializer < ActiveModel::Serializer
  attributes :token

  belongs_to :user, serializer: UserSerializer
end
