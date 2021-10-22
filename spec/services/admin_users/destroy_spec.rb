require 'rails_helper'

RSpec.describe AdminUsers::Destroy do
  subject(:outcome) { described_class.run({ id: id }) }

  let(:id) { AdminUser.first.id }

  before { create(:admin_user) }

  it 'destroys the record' do
    expect { outcome }.to change(AdminUser, :count).by(-1)
  end

  context 'when attributes are invalid' do
    let(:id) { 'id' }

    it 'sets error' do
      expect(outcome.errors.full_messages).to match_array(
        ['Id is not a valid integer']
      )
    end
  end
end
