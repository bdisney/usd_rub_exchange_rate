class ExchangeRatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "exchange_rates_#{Rails.env}"
  end
end
