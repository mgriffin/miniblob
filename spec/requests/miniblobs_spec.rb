require "rails_helper"

RSpec.describe "Miniblobs", type: :request do
  describe "GET /index" do
    it "shows an SVG embedded in a page" do
      get root_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index.svg" do
    it "returns an SVG image" do
      get "/miniblobs.svg"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(/image\/svg\+xml/)
    end
  end
end
