require 'rails_helper'

RSpec.describe 'Crops', type: :request do
  describe 'GET /crops' do
    it 'works! (now write some real specs)' do
      get crops_path
      expect(response).to have_http_status(200)
    end
  end
end
