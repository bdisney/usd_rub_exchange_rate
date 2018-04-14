require 'rails_helper'

RSpec.describe ExchangeRatesJob, type: :job do
  describe "#perform_later" do
    it 'sends exchange rates updates to the channel' do
      ActiveJob::Base.queue_adapter = :test
      expect { ExchangeRatesJob.perform_later }.to have_enqueued_job
      expect(ExchangeRatesJob).to have_been_enqueued.exactly(:once)
    end
  end
end
