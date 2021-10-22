FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    price { rand(300..500) }
    admin_user_id { create(:admin_user).id }
  end
end
