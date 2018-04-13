class ExchangeRatesJob < ApplicationJob
  queue_as :default

  def perform
    template = ApplicationController.renderer.render(partial: 'exchange_rates/exchange_rate')
    ActionCable.server.broadcast('exchange_rates', template)
  end
end
