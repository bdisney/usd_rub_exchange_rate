require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  it { should validate_presence_of :value }
  it { should validate_presence_of :valid_until }

  describe 'current_rate' do
    context 'Exchange rate does not exist' do
      it 'returns new ExchnageRate instance if exchange rates does not exist' do
        expect(ExchangeRate.current_rate).to be_a_new(ExchangeRate)
      end
    end

    context 'Exchange rate exist' do
      let!(:valid_exchange_rate) { create(:exchange_rate) }
      let(:unvalid_date)         { -1.day.from_now }

      it 'returns last instance of ExchangeRate with date is valid' do
        expect(ExchangeRate.current_rate).to eq(valid_exchange_rate)
      end

      it 'returns new instance of ExchangeRate if date is unvalid' do
        valid_exchange_rate.update(valid_until: unvalid_date)
        expect(ExchangeRate.current_rate).to_not eq(valid_exchange_rate)
        expect(ExchangeRate.current_rate).to be_a_new(ExchangeRate)
      end
    end
  end
end
