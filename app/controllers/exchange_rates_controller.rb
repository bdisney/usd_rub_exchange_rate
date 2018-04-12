class ExchangeRatesController < ApplicationController
  def new
    @rate = ExchangeRate.new
  end
end