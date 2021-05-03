require 'rails_helper'

RSpec.describe '/exercises', type: :request do
  let(:user) { create :user }
  let(:routine) { create :routine, user: user }

  let(:valid_attributes) do
    {
      data: {
        attributes: {
          name: 'Pull up',
          link: 'https://www.youtube.com/watch?v=UT57qqp3zF8',
          sets: 3,
          reps: 5,
          rest: 120,
          tempo: '20x0'
        }
      }
    }
  end

  let(:invalid_attributes) do
    {
      data: {
        attributes: {
          name: '',
          link: 'https://www.youtube.com/watch?v=UT57qqp3zF8',
          sets: 3,
          reps: 5,
          rest: 120,
          tempo: ''
        }
      }
    }
  end

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :exercise, routine: routine
      get "/routines/#{routine.id}/exercises",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      exercise = create :exercise, routine: routine
      get "/routines/#{routine.id}/exercises/#{exercise.id}",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Exercise' do
        expect do
          post "/routines/#{routine.id}/exercises",
               params: valid_attributes,
               headers: valid_headers, as: :json
        end.to change(Exercise, :count).by(1)
      end

      it 'renders a JSON response with the new exercise' do
        post "/routines/#{routine.id}/exercises",
             params: valid_attributes,
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Exercise' do
        expect do
          post "/routines/#{routine.id}/exercises",
               params: invalid_attributes,
               headers: valid_headers, as: :json
        end.to change(Exercise, :count).by(0)
      end

      it 'renders a JSON response with errors for the new exercise' do
        post "/routines/#{routine.id}/exercises",
             params: invalid_attributes,
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
          data: {
            attributes: {
              name: 'New pull up',
              link: 'https://www.youtube.com/watch?v=UT57qqp3zF8',
              sets: 3,
              reps: 5,
              rest: 120,
              tempo: '20x0'
            }
          }
        }
      end

      it 'updates the requested exercise' do
        exercise = create :exercise, routine: routine
        patch "/routines/#{routine.id}/exercises/#{exercise.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        exercise.reload
        expect(exercise.name).to eq('New pull up')
      end

      it 'renders a JSON response with the exercise' do
        exercise = create :exercise, routine: routine
        patch "/routines/#{routine.id}/exercises/#{exercise.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the exercise' do
        exercise = create :exercise, routine: routine
        patch "/routines/#{routine.id}/exercises/#{exercise.id}",
              params: invalid_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested exercise' do
      exercise = create :exercise, routine: routine
      expect do
        delete "/routines/#{routine.id}/exercises/#{exercise.id}",
               headers: valid_headers, as: :json
      end.to change(Exercise, :count).by(-1)
    end
  end
end
