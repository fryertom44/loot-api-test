require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do

  let(:other_user) { FactoryBot.create(:user) }
  let(:transfer_params) {
          { account_number_from: 666666666,
            account_number_to: 555555555,
            amount_pennies: 35,
            country_code_from: "FR",
            country_code_to: "IT",
            user_id: other_user.id
          }
  }

  describe "POST #create" do

    before(:each) do
    @transfer = FactoryBot.build(:transfer)
    @user = FactoryBot.create(:user)
    end

    context "when the credentials are correct" do

      before(:each) do
        request.headers['X-Api-Key'] = @user.api_key
        post :create, params: { transfer: transfer_params }
      end

      it "returns the transfer record corresponding to the given credentials" do
        @user.reload
        expect(response.headers['Location']).to match(/\/transfers\/\d+$/)
        # expect(response.body).to be_jsonapi_response_for('transfers')
        expect(is_jsonapi_response(response.body, 'transfers'))
      end

      it "responds with 200" do
        expect(response.status).to eq(200)
      end
    end

    context "when the credentials are incorrect" do

      before(:each) do
        request.headers['X-Api-Key'] = "invalidApiKey"
        post :create, params: { transfer: transfer_params }
      end

      it "returns a json with an error" do
        expect(
          JSON.parse(response.body, symbolize_names: true)[:errors]
        ).to eql "Not authenticated"
      end

      it "responds with 401" do
        expect(response).to have_http_status(401)
      end
    end

  describe "DELETE #destroy" do

    before(:each) do
      @transfer = FactoryBot.create :transfer
      request.headers['X-Api-Key'] = @user.api_key
      delete :destroy, params: { transfer: @transfer }
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