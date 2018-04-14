require 'rails_helper'

describe Connection do
  context '.get' do
    it 'calls Net::HTTP.get_response which returns a response' do
      VCR.use_cassette 'connection' do
        response = Connection.get(ExchangeRate::SITE_URL, ExchangeRate::APP_ID, ExchangeRate::RUB_SYMBOL)
        expect(response.code).to eq ('200')
        expect(response.body).is_a?(String)
      end
    end
  end
end
