require 'rails_helper'

RSpec.describe AccessTokensController do
  describe 'POST /create' do
    let(:params) do
      {
        data: {
          attributes: { username: 'ivancito', password: 'password' }
        }
      }
    end

    context 'when no auth_data provided' do
      subject { post :create }
      it_behaves_like 'unauthorized_standard_requests'
    end

    context 'when invalid username provided' do
      let(:user) { create :user, username: 'invalid', password: 'password' }
      subject { post :create, params: params }

      before { user }

      it_behaves_like 'unauthorized_standard_requests'
    end

    context 'when invalid password provided' do
      let(:user) { create :user, username: 'ivancito', password: 'invalid' }
      subject { post :create, params: params }

      before { user }

      it_behaves_like 'unauthorized_standard_requests'
    end

    context 'when valid data provided' do
      let(:user) { create :user, username: 'ivancito', password: 'password' }
      subject { post :create, params: params }

      before { user }

      it 'should return 201 status code' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'should return proper json body' do
        subject
        expect(json_data[:attributes]).to eq(
          { id: user.access_token.id,
            token: user.access_token.token }
        )
      end
    end
  end

  describe 'DELETE /destroy' do
    subject { delete :destroy }

    context 'when no authorization header provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid authorization header provided' do
      before { request.headers['authorization'] = 'Invalid token' }

      it_behaves_like 'forbidden_requests'
    end

    context 'when valid request' do
      let(:user) { create :user }
      let(:access_token) { user.create_access_token }

      before { request.headers['authorization'] = "Bearer #{access_token.token}" }

      it 'should return 204 status code' do
        subject
        expect(response).to have_http_status(:no_content)
      end

      it 'should remove the proper access token' do
        expect { subject }.to change { AccessToken.count }.by(-1)
      end
    end
  end
end
