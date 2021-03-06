require 'swagger_helper'

describe 'produces API' do
  path '/produces' do
    post 'Creates a produce' do
      tags 'produces'
      consumes 'application/json', 'application/xml'
      parameter name: :produce, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          duration: { type: :string },
          image: { type: :string },
        },
        required: ['name', 'duration'],
      }

      response '201', 'produce created' do
        let(:produce) { { name: 'greenbean', duration: 'march' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:produce) { { name: 'foo' } }
        run_test!
      end
    end

    get 'Gets index of all produce' do
      tags 'produces'
      produces 'application/json', 'application/xml'

      response '200', 'produces found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   duration: { type: :string },
                   image: { type: :string },
                 },
               },
               required: ['id', 'name', 'duration']

        let(:id) { produce.create(name: 'gb', duration: 'march').id }
        let(:id) { produce.create(name: 'test', duration: 'sept').id }
        run_test!
      end

      response '404', 'produce not found' do
        let(:produce) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/produces/{id}' do
    get 'Retrieves a produce' do
      tags 'produces'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'name found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 duration: { type: :string },
                 image: { type: :string },
               },
               required: ['id', 'name', 'duration']

        let(:id) { produce.create(name: 'gb', duration: 'march').id }
        run_test!
      end

      response '404', 'produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Edits a produce' do
      tags 'produces'
      consumes 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      parameter name: :produce, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          duration: { type: :string },
          image: { type: :string },
        },
        required: ['name', 'duration'],
      }

      response '204', 'produce changed' do
        let(:id) { produce.create(name: 'gb', duration: 'march').id }
        let(:produce) { { name: 'greenbean', duration: 'march' } }
        run_test!
      end

      response '404', 'produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a produce' do
      tags 'produces'
      parameter name: :id, in: :path, type: :string

      response '204', 'produce deleted' do
        let(:id) { produce.create(name: 'gb', duration: 'march').id }
        run_test!
      end

      response '404', 'produce not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
