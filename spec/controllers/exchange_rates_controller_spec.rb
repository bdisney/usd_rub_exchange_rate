require 'rails_helper'

RSpec.describe ExchangeRatesController, type: :controller do
  describe 'GET#new' do
    context 'when exchange rate currently exist' do
      let!(:exchange_rate) { create(:exchange_rate) }

      it 'assigns new rate to last rate' do
        process :new, method: :get
        expect(assigns(:rate)).to eq(exchange_rate)
      end
    end

    context 'when exchange rates does not exist' do
      it 'assigns new rate to new instance of ExchangeRate' do
        process :new, method: :get
        expect(assigns(:rate)).to be_a_new(ExchangeRate)
      end
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      let(:create_process) {
        process :create,
                method: :post,
                format: :js,
                params: {
                    exchange_rate: attributes_for(:exchange_rate)
                }
      }

      it 'saves new exchange rate to db' do
        expect { create_process }.to change(ExchangeRate, :count).by(1)
      end

      it 'render create template' do
        create_process
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let(:create_process) {
        process :create,
                method: :post,
                format: :js,
                params: {
                    exchange_rate: attributes_for(:exchange_rate, :invalid_exchange_rate)
                }
      }

      it 'does not save exchange rate to db' do
        expect { create_process }.to_not change(ExchangeRate, :count)
      end

      it 're-render create template' do
        create_process
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH#update' do
    let!(:exchange_rate) { create(:exchange_rate) }

    context 'with valid attributes' do
      before do
        process :update,
                method: :put,
                format: :js,
                params: { id: exchange_rate, exchange_rate: attributes_for(:exchange_rate) }
      end

      it 'assigns the requested rate to @rate' do
        expect(assigns(:rate)).to eq exchange_rate
      end

      it 'changes exchange rate attributes' do
        process :update, method: :patch, format: :js, params: {
          id: exchange_rate, exchange_rate: { value: 666.66 }
        }
        exchange_rate.reload
        expect(exchange_rate.value).to eq(666.66)
      end

      it 'render create template' do
        expect(response).to render_template 'exchange_rates/create.js.erb'
      end
    end

    context 'with invalid attributes' do
      it 'does not change exchange rate attributes' do
        process :update, method: :patch, format: :js, params: {
            id: exchange_rate, exchange_rate: { value: nil }
        }
        exchange_rate.reload
        expect(exchange_rate.value).to eq(30)
      end
    end
  end
end
