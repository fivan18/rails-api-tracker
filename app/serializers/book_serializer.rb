class BookSerializer
  include JSONAPI::Serializer
  attributes :title, :author
end
