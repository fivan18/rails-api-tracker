require 'rails_helper'

RSpec.describe ExercisesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/routines/1/exercises').to route_to('exercises#index', routine_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/routines/1/exercises/1').to route_to('exercises#show', routine_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/routines/1/exercises').to route_to('exercises#create', routine_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/routines/1/exercises/1').to route_to('exercises#update', routine_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/routines/1/exercises/1').to route_to('exercises#update', routine_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/routines/1/exercises/1').to route_to('exercises#destroy', routine_id: '1', id: '1')
    end

    it 'routes to #progress' do
    expect(get: '/progress/pull-up').to route_to('exercises#progress', name: 'pull-up')
  end
  end
end
