require 'swagger_helper'

describe 'users API' do
   
    path '/users' do
        post 'Creates a user' do
           tags 'users'
           consumes 'application/json', 'application/xml'
           parameter name: :user, in: :body, schema: {
               type: :object,
               properties: {
                   email: { type: :string },
                   password: { type: :string },
                   password_confirmation: { type: :string },
                   
               },
               required: [ 'email', 'password', 'password_confirmation' ]
               
           }
           response '201', 'user created' do
               let(:user) { { email: 'test@test.edu', password: 'test', password_confirmation: 'test' } }
               run_test!
           end
           
           response '422', 'invalid request' do
               let(:user) { { email: 'test@test.edu' } }
               run_test!
           end
       end
       
       
    end
end