require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'User registration api' do
    it 'A successful request creates a user in your database, and generates a unique api key associated with that user, with a 201 status code' do
      user_params = ({
                      email: 'whatever@example.com',
                      password: 'password',
                      password_confirmation: 'password'
                    })
      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      json = JSON.parse(response.body, symbolize_names: true)

      user = User.last

      expect(response).to be_successful

      expect(user.email).to eq(json[:data][:attributes][:email])
      expect(user.api_key).to eq(json[:data][:attributes][:api_key])
      expect(json[:data][:attributes]).not_to have_key([:password])
      expect(json[:data][:id]).not_to eq(nil)
      expect(json[:data][:type]).to eq('users')
    end
  end

  describe 'Users Login Api' do
    it "A successful request returns the user’s api key" do
      user_params = ({
                      email: 'another@example.com',
                      password: 'password123',
                      password_confirmation: 'password123'
                    })
      headers = {'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
      login_params =
                    {
                      email: 'another@example.com',
                      password: 'password123'
                    }
      headers = {'CONTENT_TYPE' => 'application/json'}
  
      post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)
      json = JSON.parse(response.body, symbolize_names: :true)
  binding.pry
      expect(response).to be_successful
      expect(user.email).to eq(json[:data][:attributes][:email])
      expect(user.api_key).to eq(json[:data][:attributes][:api_key])
      expect(json[:data][:attributes]).not_to have_key([:password])
      expect(json[:data][:id]).not_to eq(nil)
      expect(json[:data][:type]).to eq('users')
    end
  end
end

# Response:

# status: 200
# body:

# {
#   "data": {
#     "type": "users",
#     "id": "1",
#     "attributes": {
#       "email": "whatever@example.com",
#       "api_key": "jgn983hy48thw9begh98h4539h4"
#     }
#   }
# }