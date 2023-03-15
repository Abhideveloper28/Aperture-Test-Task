require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } } }

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'redirects to the alerts_path' do
        post :create, params: valid_params
        expect(response).to redirect_to(alerts_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { email: '', password: 'password', password_confirmation: 'password' } } }

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end

      it 'returns a JSON response with an error message' do
        post :create, params: invalid_params
        expect(response.body).to eq("")
      end
    end
  end
end
