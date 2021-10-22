require 'rails_helper'

RSpec.describe Search::AdminUsersService do
  subject(:admin_user_ids) { described_class.new(search_params).execute.ids }

  let!(:admin_users) { create_list(:admin_user, 4) }
  let(:search_params) { {} }

  it 'returns all admin users' do
    expect(admin_user_ids).to eq AdminUser.order(created_at: :desc).ids
  end

  context 'when params contain q[name]' do
    let(:search_params) { { q: { name: admin_users.first.name } } }

    it 'returns records filtered by name' do
      expect(admin_user_ids).to eq [admin_users.first.id]
    end
  end

  context 'when params contain o & d' do
    let(:search_params) { { o: 'age', d: 'asc' } }

    it 'returns data in correct order' do
      expect(admin_user_ids).to eq AdminUser.order(age: :asc).ids
    end
  end
end
