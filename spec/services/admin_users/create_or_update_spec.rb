require 'rails_helper'

RSpec.describe AdminUsers::CreateOrUpdate do
  subject(:outcome) { described_class.run({ attrs: attrs, admin_user: admin_user }) }

  let(:password_confirmation) { 'password' }
  let(:attrs) do
    {
      email: 'user1@test.com',
      name: 'User1',
      age: 25,
      phone: '9999999999',
      address: 'Test address',
      password: 'password',
      password_confirmation: password_confirmation
    }
  end

  describe 'update' do
    let(:admin_user) { create(:admin_user) }

    it 'updates the given attributes' do
      new_attributes = outcome.result.attributes.symbolize_keys.slice(*attrs.keys)
      expect(new_attributes).to eq attrs.except!(:password, :password_confirmation)
    end

    context 'when attributes are invalid' do
      let(:password_confirmation) { '' }

      it 'sets error' do
        expect(outcome.errors.full_messages).to match_array(
          ['Password confirmation doesn\'t match Password']
        )
      end
    end
  end

  describe 'create' do
    let(:admin_user) { AdminUser.new }

    it 'creates a new record' do
      expect { outcome }.to change(AdminUser, :count).by(1)
    end

    it 'sets the given attributes' do
      new_attributes = outcome.result.attributes.symbolize_keys.slice(*attrs.keys)
      expect(new_attributes).to eq attrs.except!(:password, :password_confirmation)
    end

    context 'when attributes are invalid' do
      let(:password_confirmation) { '' }

      it 'returns invalid outcome' do
        expect(outcome).not_to be_valid
      end
    end
  end
end
