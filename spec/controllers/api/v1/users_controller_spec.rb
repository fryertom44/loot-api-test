require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

 describe "POST #create" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    context "when the user is logged in" do

      before(:each) do
        @user_params = FactoryBot.attributes_for(:user)
        request.headers['X-Api-Key'] = @user.api_key
        post :create, params: { user: @user_params }
      end

      it "returns a user with a name attribute" do
        expect(
          JSON.parse(response.body, symbolize_names: true)[:name]
        ).to eql "#{@user_params[:first_name]} #{@user_params[:last_name]}"
      end

      it "returns a user with an age attribute" do
        expect(
          JSON.parse(response.body, symbolize_names: true)[:age]
        ).to eql 25
      end

      it "responds with 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the credentials are incorrect" do

      before(:each) do
        user_params = FactoryBot.attributes_for(:user)
        post :create, params: { user: user_params }
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
