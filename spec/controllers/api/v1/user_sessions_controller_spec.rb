require 'rails_helper'

RSpec.describe Api::V1::UserSessionsController, type: :controller do

  describe "POST #create" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { username: @user.username, password: "testpassword" }
        post :create, params: { user_session: credentials }
      end

      it "returns the user record corresponding to the given credentials" do
        @user.reload
        expect(
          JSON.parse(response.body, symbolize_names: true)[:api_key]
        ).to eql @user.api_key
      end

      it "responds with 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { username: @user.username, password: "invalidpassword" }
        post :create, params: { user_session: credentials }
      end

      it "returns a json with an error" do
        expect(
          JSON.parse(response.body, symbolize_names: true)[:errors]
        ).to eql "Invalid username or password"
      end

      it "responds with 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryBot.create :user
      request.headers['X-Api-Key'] = @user.api_key 
      delete :destroy
    end

    it "responds with 204" do
      expect(response).to have_http_status(204)
    end

  end

end
