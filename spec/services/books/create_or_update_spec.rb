require 'rails_helper'

RSpec.describe Books::CreateOrUpdate do
  subject(:outcome) { described_class.run({ attrs: attrs, book: book }) }

  let(:admin_user_id) { create(:admin_user).id }
  let(:price) { 150 }
  let(:name) { 'Test book' }
  let(:attrs) { { name: name, price: price, admin_user_id: admin_user_id } }

  describe 'update' do
    let(:book) { create(:book) }

    it 'updates the given attributes' do
      new_attributes = outcome.result.attributes.symbolize_keys.slice(*attrs.keys)
      expect(new_attributes).to eq attrs
    end

    context 'when name is blank' do
      let(:name) { '' }

      it 'sets error' do
        expect(outcome.errors.full_messages).to match_array(
          ['Name can\'t be blank']
        )
      end
    end

    context 'when price is 0' do
      let(:price) { 0 }

      it 'sets error' do
        expect(outcome.errors.full_messages).to match_array(
          ['Price must be greater than 0']
        )
      end
    end

    context 'when admin_user_id is invalid' do
      let(:admin_user_id) { 1 }

      it 'sets error' do
        expect(outcome.errors.full_messages).to match_array(
          ['Admin user must exist']
        )
      end
    end
  end

  describe 'create' do
    let(:book) { Book.new }

    it 'creates a new record' do
      expect { outcome }.to change(Book, :count).by(1)
    end

    it 'sets the given attributes' do
      new_attributes = outcome.result.attributes.symbolize_keys.slice(*attrs.keys)
      expect(new_attributes).to eq attrs
    end

    context 'when attributes are invalid' do
      let(:admin_user_id) { 1 }

      it 'returns invalid outcome' do
        expect(outcome).not_to be_valid
      end
    end
  end
end
