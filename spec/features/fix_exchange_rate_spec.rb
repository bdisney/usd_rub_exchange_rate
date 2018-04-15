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
    visit home_path

    Capybara.using_session('guest') do
      visit home_path
    end

    Capybara.using_session('admin') do
      visit admin_path
    end

    Capybara.using_session('admin') do
      fill_in 'exchange_rate_value', with: '36.6'
      fill_in 'exchange_rate_valid_until', with: '01.12.2118, 22:22'
      find('input[name="commit"]').click

      expect(page).to have_selector('.flash-messages', text: I18n.t('shared.messages.fixed'))
    end

    Capybara.using_session('guest') do
      expect(page).to have_content '36.6'
    end
  end
end
