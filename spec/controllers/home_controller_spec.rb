require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET#index' do
    it 'renders index template' do
      process :index, method: :get
      expect(response).to render_template :index
    end
  end
end
