# spec/support/vcr_setup.rb
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
      :match_requests_on => [:method,
                             VCR.request_matchers.uri_without_param(:url)]
  }
  c.filter_sensitive_data('<APP_ID>') { ExchangeRate::APP_ID }
end
