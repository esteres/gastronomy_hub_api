require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  let(:user) { create(:user) }
  let(:token) { AuthenticationTokenService.encode(user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  shared_examples 'fetching categories' do |category_type|
    let(:categories) { category_type == :public ? public_categories : private_categories }
    let(:endpoint) { category_type == :public ? 'public' : 'private' }
  
    before { get "/api/v1/users/#{user.id}/categories/#{endpoint}", headers: headers }
  
    context 'when user is authenticated' do
      context 'when categories exist' do
        it "returns the #{category_type} categories" do
          expect(response_body).not_to be_empty
          expect(response_body.size).to eq(categories.count)
        end
  
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  
    context 'when user is not authenticated' do
      before { get "/api/v1/users/#{user.id}/categories/#{endpoint}", headers: {} }
  
      it 'returns unauthorized status code' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /users/:user_id/categories' do
    it 'returns all categories belonging to a user' do
      create_list(:category, 3, user: user)
      get "/api/v1/users/#{user.id}/categories", headers: headers
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(3)
    end
  end

  describe 'GET /users/:user_id/categories/:id' do
    it 'returns a single category belonging to a user' do
      category = create(:category, user: user)
      get "/api/v1/users/#{user.id}/categories/#{category.id}", headers: headers
      expect(response).to have_http_status(:success)
      expect(response_body['name']).to eq(category.name)
    end
  end

  describe 'POST /users/:user_id/categories' do
    context 'with valid parameters' do
      let(:valid_attributes) { { name: 'Test Category', priority: 'low' } }

      it 'creates a new category' do
        expect {
          post "/api/v1/users/#{user.id}/categories", params: { category: valid_attributes }, headers: headers
        }.to change(Category, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'does not create a new category' do
        expect {
          post "/api/v1/users/#{user.id}/categories", params: { category: invalid_attributes }, headers: headers
        }.to_not change(Category, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /users/:user_id/categories/:id' do
    let(:category) { create(:category, user: user) }

    context 'with valid parameters' do
      let(:new_name) { 'New Name' }
      let(:valid_attributes) { { name: new_name } }

      it 'updates the category' do
        patch "/api/v1/users/#{user.id}/categories/#{category.id}", params: { category: valid_attributes }, headers: headers
        expect(response).to have_http_status(:success)
        expect(response_body['name']).to eq('new name')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'does not update the category' do
        patch "/api/v1/users/#{user.id}/categories/#{category.id}", params: { category: invalid_attributes }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users/:user_id/categories/:id' do
    let!(:category) { create(:category, user: user) }

    it 'deletes the category' do
      delete "/api/v1/users/#{user.id}/categories/#{category.id}", headers: headers
      
      expect(category.reload.active).to eq(false)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /users/:user_id/categories/public' do
    let!(:public_categories) { create_list(:category, 3, user: user, is_public: true) }
    it_behaves_like 'fetching categories', :public
  end

  describe 'GET /users/:user_id/categories/private' do
    let!(:private_categories) { create_list(:category, 2, user: user, is_public: false) }

    it_behaves_like 'fetching categories', :private
  end
end
