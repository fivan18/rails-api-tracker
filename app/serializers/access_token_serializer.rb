class AccessTokenSerializer
  include JSONAPI::Serializer
  attributes :token

  belongs_to :user, meta: proc { |access_token, _params|
    { username: access_token.user.username }
  }
end
