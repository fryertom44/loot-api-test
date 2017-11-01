require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do

  describe "GET #show" do

    before(:each) do
      @user = FactoryBot.create(:user)
      @transfer = FactoryBot.create(:transfer, user: @user)
    end

    context "incorrect credentials" do

      before(:each) do
        request.headers['X-Api-Key'] = "invalidApiKey"
        get :show, params: { user_id: @user.id, id: @transfer.id }
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

    context "correct credentials" do

      before(:each) do
        request.headers['X-Api-Key'] = @user.api_key
        get :show, params: { user_id: @user.id, id: @transfer.id }
      end

      it "responds with 200" do
        expect(response.status).to eq(200)
      end

      it "responds with jsonapi" do
        expect(response.body).to be_jsonapi_response_for 'transfers'
      end

    end

  end

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
        expect(response.body).to be_jsonapi_response_for('transfers')
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
