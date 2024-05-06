require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:email) { 'test@example.com' }
  let(:password) { 'Password1!@' }

  describe 'POST /api/v1/users' do
    context 'with valid parameters' do
      let(:valid_params) do
        { user: { email: email, password: password } }
      end

      it 'creates a new user' do
        post '/api/v1/users', params: valid_params

        expect(response).to have_http_status(:created)
        expect(response_body).to include('email' => email)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { user: { email: email, password: password } }
      end

      context 'when invalid email' do
        let(:email) { 'invalid email' }

        it 'returns unprocessable entity' do
          post '/api/v1/users', params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body)
            .to eq({
              'error' => {
                'email' => ['is invalid. Please enter a valid email address']
              }
            })
        end
      end

      context 'when email already exists' do
        let!(:user) { create(:user) }
        let(:email) { user.email }

        it 'returns unprocessable entity' do
          post '/api/v1/users', params: invalid_params
  
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body)
            .to eq({
              'error' => {
                'email' => ['is already associated with an existing user']
              }
            })
        end
      end

      context 'when invalid password' do
        let(:password) { 'invalid' }

        it 'returns unprocessable entity' do
          post '/api/v1/users', params: invalid_params
  
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body)
            .to eq({
              'error' => {
                'password' => [
                  'must contain at least 10 characters, ' \
                  'one lowercase letter, one uppercase letter, ' \
                  'and one of the following characters: !, @, #, ?, or ]'
                ]
              }
            })
        end
      end
    end
  end

  describe 'GET /api/v1/users/:id' do
    let!(:user) { create(:user) }

    context 'with existing user id' do
      it 'returns the user' do
        get "/api/v1/users/#{user.id}"

        expect(response).to have_http_status(:ok)
        expect(response_body).to include(
          'email' => user.email
        )
      end
    end

    context 'with non-existing user id' do
      it 'returns not found' do
        get '/api/v1/users/99999'

        expect(response).to have_http_status(:not_found)
        expect(response_body).to eq({
          'error'  => 'User not found'
        })
      end
    end
  end

  describe 'PATCH /api/v1/users/:id' do
    let!(:user) { create(:user) }

    context 'with valid parameters' do
      let(:valid_params) { { user: { email: 'new_email@example.com' } } }

      it 'updates the user' do
        patch "/api/v1/users/#{user.id}", params: valid_params

        expect(response).to have_http_status(:ok)
        expect(response_body).to include('email' =>'new_email@example.com')

        user.reload
        expect(user.email).to eq('new_email@example.com')
      end
    end

    context 'with invalid parameters' do
      context 'when invalid email' do
        let(:invalid_params) do
          { user: { email: 'invalid email' } }
        end

        it 'returns unprocessable entity' do
          patch "/api/v1/users/#{user.id}", params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body)
            .to eq({
              'error' => {
                'email' => ['is invalid. Please enter a valid email address']
              }
            })
        end
      end

      context 'when invalid password' do
        let(:invalid_params) do
          { user: { password: 'invalid' } }
        end

        it 'returns unprocessable entity' do
          patch "/api/v1/users/#{user.id}", params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response_body)
            .to eq({
              'error' => {
                'password' => [
                  'must contain at least 10 characters, ' \
                  'one lowercase letter, one uppercase letter, ' \
                  'and one of the following characters: !, @, #, ?, or ]'
                ]
              }
            })
        end
      end
    end
  end
end
