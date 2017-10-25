require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

 describe "POST #create" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context "when the user is logged in" do

      before(:each) do
        @user_params = FactoryBot.attributes_for(:user)
        @full_name = "#{@user_params[:first_name]} #{@user_params[:last_name]}"
        request.headers['X-Api-Key'] = @user.api_key
        post :create, params: { user: @user_params }
      end

      it "returns a user with a name attribute" do
        expect(
          JSON.parse(response.body).dig('data', 'attributes', 'name')
        ).to eql @full_name
      end

      it "returns a user with an age attribute" do
        expect(
          JSON.parse(response.body).dig('data', 'attributes', 'age')
        ).to eql 25
      end

      it "responds with 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the user is not logged in" do

      before(:each) do
        request.headers['X-Api-Key'] = "InvalidApiKey"
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
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
      @user = FactoryBot.create :user
      @other_user = FactoryBot.create :user
      request.headers['X-Api-Key'] = @user.api_key
      delete :destroy, params: { id: @other_user.id }
    end

    it "responds with 204" do
      expect(response).to have_http_status(204)
    end

  end
end

def is_jsonapi_response actual, model
  parsed_actual = JSON.parse(actual)
  parsed_actual.dig('data', 'type') == model &&
  parsed_actual.dig('data', 'attributes').is_a?(Hash) &&
  parsed_actual.dig('data', 'relationships').is_a?(Hash)
end
