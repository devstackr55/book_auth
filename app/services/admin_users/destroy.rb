module AdminUsers
  class Destroy < ActiveInteraction::Base
    integer :id

    validates :id, numericality: { greater_than: 0 }

    def execute
      AdminUser.find(id).destroy
    rescue StandardError => e
      errors.add(:standard_error, e)
    end
  end
end
