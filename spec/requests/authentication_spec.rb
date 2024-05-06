require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { create(:user) }
    let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MTUwMDEyNDB9.PqeRY7NpJw706oi8-3kuEpydjBawx0fG5J6DxdgCj3I' }

    before do
      allow(AuthenticationTokenService).to receive(:encode).and_return(token)
    end

    it 'authenticates the client' do
      post '/api/v1/authenticate', params: {
        email: user.email,
        password: user.password
      }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
        'token' => token
      })
    end

    it 'returns error when email is missing' do
      post '/api/v1/authenticate', params: {
        password: user.password
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: email'
      })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: {
        email: user.email
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: {
        email: user.email,
        password: 'incorrect'
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end

