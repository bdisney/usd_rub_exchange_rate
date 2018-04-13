class ExchangeRate < ApplicationRecord
  USD_RUB_PAIR = 'USD_RUB'.freeze
  SITE_URL     = 'http://free.currencyconverterapi.com/api/v3/convert?q=USD_RUB&compact=ultra'.freeze

  validates :value, :valid_until, presence: true
  validate  :valid_until_date_should_be_greater_than_current

  def self.current_rate
    valid_exchange_rate_present? ? ExchangeRate.last.value : realtime_rate_for(USD_RUB_PAIR)
  end

  def valid_until_date_should_be_greater_than_current
    return unless valid_until
    errors.add(
      :valid_until,
      I18n.t('activerecord.errors.models.exchange_rate.attributes.valid_until.should_be_greater_than')
    ) if valid_until < Date.current
  end

  private

  def self.realtime_rate_for(pair_rate)
    uri      = URI(SITE_URL)
    response = Net::HTTP.get(uri)
    format '%.2f', JSON.parse(response)[pair_rate]
  end

  def self.valid_exchange_rate_present?
    return false unless ExchangeRate.last
    ExchangeRate.last.valid_until > Date.current
  end
end
