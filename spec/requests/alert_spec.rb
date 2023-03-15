require 'rails_helper'

RSpec.describe AlertsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:user) { User.create(email: "abc@gmail.com", password: "123456") }
      let(:token) {JsonWebToken.encode(user_id: user.id)}
      let(:valid_params) {{ alert_type: 'portal_closed', description: 'A portal was opened', origin: '123.89.00.2' , tags: '["verions2.3.9", "production"]'} }

      it 'creates a new alert' do
        expect {
          post :create, params: valid_params
        }.to change(Alert, :count).by(0)
      end

      it 'redirects to the alerts_path' do
        post :create, params: {params: valid_params, token: token}
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) {{ alert_type: ' ', description: 'A portal was opened', origin: '123.89.00.2' , tags: '["verions2.3.9", "production"]'} }

      it 'does not create a new alert' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Alert, :count)
      end

      it 'returns a JSON response with an error message' do
        post :create, params: invalid_params
        expect(response.body).to eq("{\"errors\":\"Nil JSON web token\"}")
      end
    end
  end
end
