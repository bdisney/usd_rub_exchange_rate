class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.decimal  :value, precision: 12, scale: 1
      t.datetime :valid_until

      t.timestamps null: false
    end
  end
end
