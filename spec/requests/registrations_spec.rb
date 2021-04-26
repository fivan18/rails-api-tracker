require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /create' do
    subject { post :create, params: params }
    context 'when invalid data provided' do
      let(:params) do
        {
          data: {
            attributes: {
              login: nil,
              password: nil
            }
          }
        }
      end

      it 'should return unprecessable_entity status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not create a user' do
        subject
        expect { subject }.not_to(change { User.count })
      end

      it 'should return an error message in the response body' do
        subject
        expect(json[:errors]).to include(
          {
            login: ["can't be blank"]
          },
          {
            password: ["can't be blank"]
          }
        )
      end
    end

    context 'when valid data provided' do
      let(:params) do
        {
          data: {
            attributes: {
              username: 'ivancito',
              password: 'ivancitopassword'
            }
          }
        }
      end

      it 'should return 201 http status code ' do
        subject
        expect(response).to have_http_status(:create)
      end

      it 'should create a user' do
        expect(User.exists?(username: 'ivancito')).to be_falsey
        expect { subject }.to change { User.count }.by(1)
        expect(User.exists?(username: 'ivancito')).to be_truthy
      end

      it 'should return proper json' do
        subject
        expect(json_data[:attributes]).to include({
                                                    username: 'ivancito'
                                                  })
      end
    end
  end
end
