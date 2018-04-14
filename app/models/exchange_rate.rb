class ExchangeRate < ApplicationRecord
  RUB_SYMBOL = 'RUB'.freeze
  SITE_URL   = 'https://openexchangerates.org/api/latest.json?'
  APP_ID     = ENV['APP_ID']

  validates :value, :valid_until, presence: true

  scope :valid_until_greater_than_current_date, -> { where('valid_until > ?', DateTime.current) }

  def self.current_rate
    if valid_until_greater_than_current_date.present?
      ExchangeRate.last
    else
      ExchangeRate.new(value: get_external_value)
    end
  end

  private

  def self.get_external_value
    response = Connection.get(SITE_URL, APP_ID, RUB_SYMBOL)
    return unless response.code == '200'
    JSON.parse(response.body)['rates'][RUB_SYMBOL]
  end
end
