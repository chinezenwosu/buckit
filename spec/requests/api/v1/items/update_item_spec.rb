require "rails_helper"

RSpec.describe "Update Item", type: :request do
  describe "PUT #update" do
    let!(:item) do
      create :list
      create :item
    end

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "put", "/api/v1/bucketlists/1/items/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list item" do
        params = attributes_for(:item, :updated)
        put "/api/v1/bucketlists/1/items/1", params: params

        expect(response.status).to be(200)
        expect(Item.first.name).to eq("MyBucket")
      end
    end

    context "when user provide invalid parameters" do
      route = "/api/v1/bucketlists/1/items/1"
      it_behaves_like("invalid parameters", "put", route)
    end

    context "when the bucket list item does not exist" do
      route = "/api/v1/bucketlists/1/items/3"
      it_behaves_like("missing parameters", "put", route)
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "put", "/api/v1/bucketlists/1/item/1")
    end
  end
end
