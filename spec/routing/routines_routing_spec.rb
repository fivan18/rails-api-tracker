require 'rails_helper'

RSpec.describe RoutinesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/routines').to route_to('routines#index')
    end

    it 'routes to #show' do
      expect(get: '/routines/1').to route_to('routines#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/routines').to route_to('routines#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/routines/1').to route_to('routines#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/routines/1').to route_to('routines#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/routines/1').to route_to('routines#destroy', id: '1')
    end
  end
end
