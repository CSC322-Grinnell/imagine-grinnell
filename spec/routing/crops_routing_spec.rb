require 'rails_helper'

RSpec.describe CropsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/crops').to route_to('crops#index')
    end

    it 'routes to #new' do
      expect(:get => '/crops/new').to route_to('crops#new')
    end

    it 'routes to #show' do
      expect(:get => '/crops/1').to route_to('crops#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/crops/1/edit').to route_to('crops#edit', :id => '1')
    end


    it 'routes to #create' do
      expect(:post => '/crops').to route_to('crops#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/crops/1').to route_to('crops#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/crops/1').to route_to('crops#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/crops/1').to route_to('crops#destroy', :id => '1')
    end
  end
end
