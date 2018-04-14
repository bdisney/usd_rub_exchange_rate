# set :output, { error: 'log/cron.log', standard: 'log/cron.log' }
set :environment, :development

every 1.hour do
  runner 'ExchangeRatesJob.perform_later'
end
