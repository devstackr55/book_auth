class User < ApplicationRecord
  devise :database_authenticatable

  has_many :refresh_auth_tokens, as: :identical, dependent: :destroy
end
