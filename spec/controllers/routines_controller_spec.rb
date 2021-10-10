require 'rails_helper'

RSpec.describe '/routines', type: :request do
  let(:user) { create :user }

  let(:valid_attributes) { { day: '20210521' } }

  let(:invalid_attributes) { { day: '' } }

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :routine, user: user
      get routines_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      routine = create :routine, user: user
      get routine_url(routine), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Routine' do
        expect do
          post routines_url,
               params: {
                 routine: valid_attributes
               }, headers: valid_headers, as: :json
        end.to change(Routine, :count).by(1)
      end

      it 'renders a JSON response with the new routine' do
        post routines_url,
             params: {
               routine: valid_attributes
             }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Routine' do
        expect do
          post routines_url,
               params: { routine: invalid_attributes },
               headers: valid_headers, as: :json
        end.to change(Routine, :count).by(0)
      end

      it 'renders a JSON response with errors for the new routine' do
        post routines_url,
             params: { routine: invalid_attributes },
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          day: '20210912'
        }
      end

      it 'updates the requested routine' do
        routine = create :routine, user: user
        expect do
          patch routine_url(routine),
                params: { routine: new_attributes },
                headers: valid_headers, as: :json
          routine.reload
        end.to change(Routine, :count).by(0)
      end

      it 'renders a JSON response with the routine' do
        routine = create :routine, user: user
        patch routine_url(routine),
              params: { routine: new_attributes },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the routine' do
        routine = create :routine, user: user
        patch routine_url(routine),
              params: { routine: invalid_attributes },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested routine' do
      routine = create :routine, user: user
      expect do
        delete routine_url(routine), headers: valid_headers, as: :json
      end.to change(Routine, :count).by(-1)
    end
  end
end
