require 'rails_helper'

RSpec.describe Books::Destroy do
  subject(:outcome) { described_class.run({ id: id }) }

  let(:id) { Book.first.id }

  before { create(:book) }

  it 'destroys the record' do
    expect { outcome }.to change(Book, :count).by(-1)
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
