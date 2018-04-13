class ExchangeRate < ApplicationRecord
  USD_RUB_PAIR = 'USD_RUB'.freeze
  SITE_URL     = 'http://free.currencyconverterapi.com/api/v3/convert?q=USD_RUB&compact=ultra'.freeze

  validates :value, :valid_until, presence: true

  scope :valid_until_greater_than_current_date, -> { where('valid_until > ?', DateTime.current) }

  def self.current_rate
    if valid_until_greater_than_current_date.present?
      ExchangeRate.last
    else
      ExchangeRate.new(value: realtime_rate_for(USD_RUB_PAIR))
    end
  end

  private

  def self.realtime_rate_for(pair_rate)
    uri      = URI(SITE_URL)
    response = Net::HTTP.get(uri)
    format '%.2f', JSON.parse(response)[pair_rate]
  end
end
