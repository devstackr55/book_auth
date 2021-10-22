module Books
  class CreateOrUpdate < ActiveInteraction::Base
    record :book

    hash :attrs do
      string :name, default: nil
      integer :price, default: nil
      integer :admin_user_id, default: nil
    end

    def execute
      book.attributes = attrs.compact

      errors.merge!(book.errors) unless book.save

      book
    end
  end
end
