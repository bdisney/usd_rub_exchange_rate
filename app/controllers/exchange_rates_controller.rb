class ExchangeRatesController < ApplicationController
  after_action :update_exchange_rate_channel, only: :create

  def new
    @rate = ExchangeRate.new
  end

  def create
    @rate = ExchangeRate.new(exchange_rate_params)
    @rate.save
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:id, :value, :valid_until)
  end

  #можно использовать callback в модели, но это вопрос для обсуждения
  def update_exchange_rate_channel
    ExchangeRatesJob.perform_now
  end
end
