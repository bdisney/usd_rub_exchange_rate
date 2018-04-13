class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.decimal  :value, precision: 6, scale: 2
      t.datetime :valid_until

      t.timestamps null: false
    end
  end
end
