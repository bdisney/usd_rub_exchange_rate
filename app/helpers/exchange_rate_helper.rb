module ExchangeRateHelper
  def date_time_with_format(value)
    value.strftime("%d.%m.%Y, %H:%M")
  end

  def current_date_time
    DateTime.current
  end
end