require 'swagger_helper'

describe 'gardens API' do

  path '/gardens' do
    
    post 'Creates a garden' do
      tags 'gardens'
      consumes 'application/json', 'application/xml'
      parameter name: :garden, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          address: { type: :string },
          lat: { type: :number },
          long: { type: :number },
          contact_name: { type: :string },
          contact_number: { type: :string},
          email: { type: :string },
        },
        required: [ 'name', 'address', 'lat', 'long', 'contact_name', 'contact_number', 'email' ]
      }

      response '201', 'garden created' do
        let(:garden) { { name: 'Fake Garden', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:garden) { { name: 'foo' } }
        run_test!
      end
    end
    
    get 'Gets index of all garden' do
      tags 'gardens'
      produces 'application/json', 'application/xml'

      response '200', 'gardens found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              name: { type: :string },
              address: { type: :string },
              lat: { type: :number },
              long: { type: :number },
              contact_name: { type: :string },
              contact_number: { type: :string},
              email: { type: :string },
            },
          },
          required: ['id', 'name', 'address', 'lat', 'long', 'contact_name', 'contact_number', 'email' ]

        let(:id) { Garden.create(name: 'Fake Garden', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com').id }
        let(:id) { Garden.create(name: 'Fake Garden 2', address: '1111 Garden Ave. S.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com').id }
        run_test!
      end
    end
  end

  path '/gardens/{id}' do

    get 'Retrieves a garden' do
      tags 'gardens'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            address: { type: :string },
            lat: { type: :number },
            long: { type: :number },
            contact_name: { type: :string },
            contact_number: { type: :string},
            email: { type: :string },
          },
        required: ['id', 'name', 'address', 'lat', 'long', 'contact_name', 'contact_number', 'email' ]

        let(:id) { Garden.create(name: 'Fake Garden', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com').id }
        run_test!
      end

      response '404', 'garden not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    
    patch 'Edits a garden' do
      tags 'gardens'
      consumes 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :garden, in: :body, schema: {
        type: :object,
        properties: {
            name: { type: :string },
            address: { type: :string },
            lat: { type: :number },
            long: { type: :number },
            contact_name: { type: :string },
            contact_number: { type: :string},
            email: { type: :string },
        },
        required: ['id', 'name', 'address', 'lat', 'long', 'contact_name', 'contact_number', 'email' ]
      }
      
      response '204', 'garden changed' do
        let(:id) { Garden.create(name: 'Fake Garden', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com').id }
        let(:garden) { { name: 'Fake Garden 2', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com'} }
        run_test!
      end
      
      response '404', 'garden not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    
    delete 'Deletes a garden' do
      tags 'gardens'
      parameter name: :id, :in => :path, :type => :string
      
      response '204', 'garden deleted' do
        let(:id) { Garden.create(name: 'Fake Garden', address: '5555 Garden Ave. N.', lat: 12, long: 12, contact_name: 'Test Person', contact_number: '555-555-5555', email: 'FakePerson@fake.com').id }
        run_test!
      end
      
      response '404', 'garden not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end