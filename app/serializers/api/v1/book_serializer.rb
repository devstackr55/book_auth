class Api::V1::BookSerializer < BaseSerializer
  attributes :id, :name, :price, :created_at, :updated_at

  belongs_to :admin_user, serializer: Api::V1::AdminUserSerializer
end
