require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do

  describe "POST #create" do

    before(:each) do
      @user = FactoryBot.create(:user)
      @transfer_params = FactoryBot.attributes_for(:transfer, user: @user)
    end

    context "when the credentials are correct" do

      before(:each) do
        request.headers['X-Api-Key'] = @user.api_key
        post :create, params: { transfer: @transfer_params, user_id: @user.id }
      end

      it "returns the transfer record corresponding to the given credentials" do
        expect(response.headers['Location']).to match(/\/transfers\/\d+$/)
        expect(is_jsonapi_response(response.body, 'transfers'))
      end

      it "responds with 200" do
        expect(response.status).to eq(200)
      end
    end

    context "when the credentials are incorrect" do

      before(:each) do
        request.headers['X-Api-Key'] = "invalidApiKey"
        post :create, params: { transfer: @transfer_params, user_id: @user.id }
      end

      it "returns a json with an error" do
        expect(
          JSON.parse(response.body).dig('errors')
        ).to eql "Not authenticated"
      end

      it "responds with 401" do
        expect(response).to have_http_status(401)
      end
    end

  describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryBot.create(:user)
      @transfer = FactoryBot.create(:transfer, user: @user)
      request.headers['X-Api-Key'] = @user.api_key
      delete :destroy, params: { user_id: @user.id, id: @transfer.id }
    end

    it "responds with 204" do
      expect(response).to have_http_status(204)
    end

  end

  end

end

def is_jsonapi_response actual, model
  parsed_actual = JSON.parse(actual)
  parsed_actual.dig('data', 'type') == model &&
  parsed_actual.dig('data', 'attributes').is_a?(Hash) &&
  parsed_actual.dig('data', 'relationships').is_a?(Hash)
end

