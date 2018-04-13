App.exchange_rates = App.cable.subscriptions.create "ExchangeRatesChannel",
  received: (rate_value)->
    $('.js-exchange-rate').html(rate_value)