class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :trackable, :recoverable

  has_many :books, dependent: :destroy

  validates :age, numericality: { only_integer: true, greater_than: 0, allow_blank: true }

  scope :by_name, ->(name) { where(arel_table[:name].matches("%#{name}%")) }
end
