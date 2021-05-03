require 'rails_helper'

RSpec.describe "/books", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      create :book
      get books_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book = create :book
      get book_url(book), as: :json
      expect(response).to be_successful
    end
  end
end
