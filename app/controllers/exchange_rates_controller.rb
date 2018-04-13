class ExchangeRatesController < ApplicationController
  before_action :set_rate, only: :update
  after_action  :update_exchange_rate_channel, only: %i[create update]

  def new
    @rate = ExchangeRate.last || ExchangeRate.new
  end

  def create
    @rate = ExchangeRate.new(exchange_rate_params)
    @rate.save
  end

  def update
    @rate.update(exchange_rate_params)
    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:id, :value, :valid_until)
  end

  #можно использовать callback в модели, но это вопрос для обсуждения
  def update_exchange_rate_channel
    ExchangeRatesJob.perform_later
  end

  def set_rate
    @rate = ExchangeRate.find(params[:id])
  end
end
