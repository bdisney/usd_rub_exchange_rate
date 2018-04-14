require 'feature_spec_helper'

feature 'Fix exchange rate', %q{
  In order to fix exchange rate
  As an admin
  I want to be able to do it
} do

  scenario 'Admin can fix exchange rate with valid data', js: true do
    visit admin_path
    fill_in 'exchange_rate_value', with: '36.6'
    fill_in 'exchange_rate_valid_until', with: DateTime.tomorrow
    find('input[name="commit"]').click

    expect(page).to have_selector('.flash-messages', text: I18n.t('shared.messages.fixed'))
    expect(find_field('exchange_rate_value').value).to eq('36.6')
  end

  scenario 'Admin can not fix exchange rate with invalid data', js: true do
    visit admin_path
    fill_in 'exchange_rate_value', with: nil
    fill_in 'exchange_rate_valid_until', with: nil
    find('input[name="commit"]').click

    blank_error_message = I18n.t('activerecord.errors.models.exchange_rate.attributes.default_settings.blank')
    expect(page).to have_selector(
      '.alert',
      text: "#{ExchangeRate.human_attribute_name(:value)} #{blank_error_message}"
    )
    expect(page).to have_selector(
      '.alert',
      text: "#{ExchangeRate.human_attribute_name(:valid_until)} #{blank_error_message}"
    )
  end

  scenario 'All users see fixed exchange rate in real-time', js: true do
    value      = '666.77'
    valid_date = '22.04.2118, 22:36'

    open_new_window
    visit home_path
    expect(page).not_to have_content(value)

    switch_to_window(windows.last)
    visit ('http://localhost:3000/admin')

    fill_in 'exchange_rate_value', with: value
    fill_in 'exchange_rate_valid_until', with: valid_date
    find('input[name="commit"]').click

    switch_to_window(windows.first)
    expect(page).to have_text(value)
  end
end
