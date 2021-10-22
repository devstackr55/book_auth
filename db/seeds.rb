AdminUser.create(email: 'admin@test.com', password: 'admintest')

50.times { FactoryBot.create(:admin_user) }

admin_user_ids = AdminUser.ids
150.times { FactoryBot.create(:book, admin_user_id: admin_user_ids.sample) }

FactoryBot.create(:user, email: 'user@test.com', password: 'usertest')
