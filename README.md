[![Build Status](https://travis-ci.org/bdisney/usd_rub_exchange_rate.svg?branch=master)](https://travis-ci.org/bdisney/usd_rub_exchange_rate)

# USD/RUB exchange rate 

Приложение содержит две страницы: / и /admin

• На странице / отображается текущий курс доллара к рублю, известный
приложению.

• Приложение фоновым скриптом периодически обновляет курс из источника - https://openexchangerates.org

Для доступа к источнику потребуется app_id (доступен после регистрации на сайте источника), который нужно добавть в файл .env по римеру того, как это сделано в sample.env.  
Периодичность запросов к источнику задается в congig/shedule.rb. Более продробно про периодичность здесь - https://github.com/javan/whenever

```ruby
every 1.hour do # 
  ...
end
```    

После указания периодичности необходимо выполнить

```ruby
whenever --update-crontab 
```    

• При обновлении курса в приложении он обновляется на всех открытых в
текущий момент страницах.

• На странице /admin находится форма, содержащая поле для ввода числа,
поле для ввода даты-времени и сабмит.

• При сабмите введенное число делается форсированным курсом до введённого
времени, т.е. до этого времени реальный курс игнорируется, вместо него
страницах / отображается форсированный курс. 

• Страница /admin «помнит» введенные предыдущий раз значения, они
отображаются уже введенными при загрузке страницы.

• При сабмите форсированного курса он обновляется на всех
открытых страницах. При истечении времени действия форсированного
курса на всех страницах начинает отображаться реальный курс.

• Старт приложения осуществляется командой (при условии, что установлен gem 'foreman'): 
```ruby
foreman start

```  
или:

```ruby
redis-server
bundle exec sidekiq
bundle exec rails s
```  
