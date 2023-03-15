require 'rails_helper'

RSpec.describe AuthenticationsController, type: :controller do
  describe "POST #create" do
    context "with valid credentials" do
      let(:user) { User.create(email: "abc@gmail.com", password: "123456") }
      
      it "creates a new session token" do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:token]).to be_present
      end
    end

    context "with invalid credentials" do
      it "responds with a 401 status code" do
        post :create, params: { email: "invalid_email@example.com", password: "invalid_password" }
        expect(response).to have_http_status(401)
      end

      it "does not create a new session token" do
        post :create, params: { email: "invalid_email@example.com", password: "invalid_password" }
        expect(session[:token]).to be_nil
      end

      it "returns an error message in JSON format" do
        post :create, params: { email: "invalid_email@example.com", password: "invalid_password" }
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("unauthorized")
      end
    end
  end
end
