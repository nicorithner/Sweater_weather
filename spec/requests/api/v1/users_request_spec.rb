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

    describe "Test for sad path. An unsuccessful request returns corresponding 400 status body with error description" do
      it "Blank email request returns status 406 and a body with error description" do
        user_params = ({
                        password: 'password123',
                        password_confirmation: 'password123'
                      })
        headers = {'CONTENT_TYPE' => 'application/json'}
  
        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
        json = JSON.parse(response.body, symbolize_names: :true)

        user = User.last
  
        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Email cannot be blank')
      end

      it "Blank password request returns status 406 and a body with error description" do
        user_params = ({
                        email: 'another@example.com',
                        password_confirmation: 'password123'
                      })
        headers = {'CONTENT_TYPE' => 'application/json'}
  
        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
        json = JSON.parse(response.body, symbolize_names: :true)
        
        user = User.last
  
        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Password cannot be blank')
      end
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
      
      user = User.last

      expect(response).to be_successful
      expect(user.email).to eq(json[:data][:attributes][:email])
      expect(user.api_key).to eq(json[:data][:attributes][:api_key])
      expect(json[:data][:attributes]).not_to have_key([:password])
      expect(json[:data][:id]).not_to eq(nil)
      expect(json[:data][:type]).to eq('sessions')
    end
    
    describe "Test for sad path. An unsuccessful request returns corresponding 400 status body with error description" do
      it "Wrong email or password request returns status 401 and a body with error description" do
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
                        password: 'password456'
                      }
        headers = {'CONTENT_TYPE' => 'application/json'}
    
        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)
        json = JSON.parse(response.body, symbolize_names: :true)
        
        user = User.last
  
        expect(response).not_to be_successful
        expect(response).to have_http_status(401)
        expect(json[:message]).to eq('Your email or password was incorrect')
      end

      it "Blank email request returns status 406 and a body with error description" do
        user_params = ({
                        email: 'another@example.com',
                        password: 'password123',
                        password_confirmation: 'password123'
                      })
        headers = {'CONTENT_TYPE' => 'application/json'}
  
        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
        login_params =
                      {
                        password: 'password123'
                      }
        headers = {'CONTENT_TYPE' => 'application/json'}
    
        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)
        json = JSON.parse(response.body, symbolize_names: :true)
        
        user = User.last
  
        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Email cannot be blank')
      end

      it "Blank password request returns status 406 and a body with error description" do
        user_params = ({
                        email: 'another@example.com',
                        password: 'password123',
                        password_confirmation: 'password123'
                      })
        headers = {'CONTENT_TYPE' => 'application/json'}
  
        post '/api/v1/users', headers: headers, params: JSON.generate(user_params)
        login_params =
                      {
                        email: 'another@example.com'
                      }
        headers = {'CONTENT_TYPE' => 'application/json'}
    
        post '/api/v1/sessions', headers: headers, params: JSON.generate(login_params)
        json = JSON.parse(response.body, symbolize_names: :true)
        
        user = User.last
  
        expect(response).not_to be_successful
        expect(response).to have_http_status(406)
        expect(json[:message]).to eq('Password cannot be blank')
      end
    end
  end
end