FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'password' }
    password_confirmation { password }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    age { rand(20..40) }
  end
end
