class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :username
end
