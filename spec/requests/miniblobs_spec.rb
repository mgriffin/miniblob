require "rails_helper"

RSpec.describe "Miniblobs", type: :request do
  describe "GET /index" do
    it "shows an SVG" do
      get root_url
      expect(response).to have_http_status(:success)
    end
  end
end
