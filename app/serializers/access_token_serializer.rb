class AccessTokenSerializer
  include JSONAPI::Serializer
  attributes :token

  belongs_to :user
end
