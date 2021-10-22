class Book < ApplicationRecord
  belongs_to :admin_user

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  scope :recent, -> { order(id: :desc) }
end
