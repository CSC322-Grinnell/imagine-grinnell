require 'rails_helper'

RSpec.describe "Volunteers", type: :request do
  describe "GET /volunteers" do
    it "works! (now write some real specs)" do
      get volunteers_path
      expect(response).to have_http_status(200)
    end
  end
end
