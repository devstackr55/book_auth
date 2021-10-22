module AdminUsers
  class CreateOrUpdate < ActiveInteraction::Base
    record :admin_user

    hash :attrs do
      string :email
      string :name
      integer :age, default: nil
      string :phone
      string :address
      string :password
      string :password_confirmation
    end

    def execute
      attrs.except!(:password, :password_confirmation) if attrs[:password].blank?
      admin_user.attributes = attrs

      errors.merge!(admin_user.errors) unless admin_user.save

      admin_user
    end
  end
end
