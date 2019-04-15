require 'swagger_helper'

describe 'garden_produces API' do

  path '/garden_produces' do
    
    post 'Creates a garden_produce' do
      tags 'garden_produces'
      consumes 'application/json', 'application/xml'
      parameter name: :garden_produce, in: :body, schema: {
        type: :object,
        properties: {
          garden_id: { type: :number },
          produce_id: { type: :number },
          available_at: { type: :string },
          readiness: { type: :number },
          planted_at: { type: :string},
        },
        required: [ 'garden_id', 'produce_id', 'available_at', 'readiness' ]
      }

      response '201', 'garden_produce created' do
        let(:garden_produce) { { garden_id: '2', produce_id: '2', available_at: 'March 12', readiness: 0} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:garden_produce) { { name: 'foo' } }
        run_test!
      end
    end
    
    get 'Gets index of all garden_produce' do
      tags 'garden_produces'
      produces 'application/json', 'application/xml'

      response '200', 'garden_produces found' do
        schema type: :array,
          items: {
            properties: {
              garden_id: { type: :number },
              produce_id: { type: :number },
              available_at: { type: :string },
              readiness: { type: :number },
              planted_at: { type: :object},
            },
          },
          required: [ 'garden_id', 'produce_id', 'available_at', 'readiness' ]

        let(:id) { Garden.create(garden_id: '2', produce_id: '2', available_at: 'March 12', readiness: 0).id }
        let(:id) { Garden.create(garden_id: '1', produce_id: '2', available_at: 'March 13', readiness: 0).id }
        run_test!
      end
    end
  end

  path '/garden_produces/{id}' do

    get 'Retrieves a garden_produce' do
      tags 'garden_produces'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            garden_id: { type: :number },
            produce_id: { type: :number },
            available_at: { type: :string },
            readiness: { type: :number },
            planted_at: { type: :object},
          },
          required: [ 'garden_id', 'produce_id', 'available_at', 'readiness' ]

        let(:id) { Garden.create(garden_id: '2', produce_id: '2', available_at: 'March 12', readiness: 0).id }
        run_test!
      end

      response '404', 'garden_produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    
    patch 'Edits a garden_produce' do
      tags 'garden_produces'
      consumes 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :garden_produce, in: :body, schema: {
        type: :object,
        properties: {
          garden_id: { type: :number },
          produce_id: { type: :number },
          available_at: { type: :string },
          readiness: { type: :number },
          planted_at: { type: :object},
        },
          required: [ 'garden_id', 'produce_id', 'available_at', 'readiness' ]
      }
      
      response '204', 'garden_produce changed' do
        let(:id) { Garden.create(garden_id: '2', produce_id: '2', available_at: 'March 12', readiness: 0).id }
        let(:garden_produce) { { garden_id: '2', produce_id: '8', available_at: 'March 12', readiness: 0 } }
        run_test!
      end
      
      response '404', 'garden_produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    
    delete 'Deletes a garden_produce' do
      tags 'garden_produces'
      parameter name: :id, :in => :path, :type => :string
      
      response '204', 'garden_produce deleted' do
        let(:id) { Garden.create(garden_id: '2', produce_id: '2', available_at: 'March 12', readiness: 0).id }
        run_test!
      end
      
      response '404', 'garden_produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end