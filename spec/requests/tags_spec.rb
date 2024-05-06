require 'rails_helper'

RSpec.describe 'Tags API', type: :request do
  let(:user) { create(:user) }
  let(:token) { AuthenticationTokenService.encode(user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  shared_examples 'fetching tags' do |tag_type|
    let(:tags) { tag_type == :public ? public_tags : private_tags }
    let(:endpoint) { tag_type == :public ? 'public' : 'private' }
  
    before { get "/api/v1/users/#{user.id}/tags/#{endpoint}", headers: headers }
  
    context 'when user is authenticated' do
      context 'when tags exist' do
        it "returns the #{tag_type} tags" do
          expect(response_body).not_to be_empty
          expect(response_body.size).to eq(tags.count)
        end
  
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  
    context 'when user is not authenticated' do
      before { get "/api/v1/users/#{user.id}/tags/#{endpoint}", headers: {} }
  
      it 'returns unauthorized status code' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /users/:user_id/tags' do
    it 'returns all tags belonging to a user' do
      create_list(:tag, 3, user: user)
      get "/api/v1/users/#{user.id}/tags", headers: headers
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(3)
    end
  end

  describe 'GET /users/:user_id/tags/:id' do
    it 'returns a single tag belonging to a user' do
      tag = create(:tag, user: user)
      get "/api/v1/users/#{user.id}/tags/#{tag.id}", headers: headers
      expect(response).to have_http_status(:success)
      expect(response_body['name']).to eq(tag.name)
    end
  end

  describe 'POST /users/:user_id/tags' do
    context 'with valid parameters' do
      let(:valid_attributes) { { name: 'Test tag', priority: 'low' } }

      it 'creates a new tag' do
        expect {
          post "/api/v1/users/#{user.id}/tags", params: { tag: valid_attributes }, headers: headers
        }.to change(Tag, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'does not create a new tag' do
        expect {
          post "/api/v1/users/#{user.id}/tags", params: { tag: invalid_attributes }, headers: headers
        }.to_not change(Tag, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /users/:user_id/tags/:id' do
    let(:tag) { create(:tag, user: user) }

    context 'with valid parameters' do
      let(:new_name) { 'New Name' }
      let(:valid_attributes) { { name: new_name } }

      it 'updates the tag' do
        patch "/api/v1/users/#{user.id}/tags/#{tag.id}", params: { tag: valid_attributes }, headers: headers
        expect(response).to have_http_status(:success)
        expect(response_body['name']).to eq('new name')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: nil } }

      it 'does not update the tag' do
        patch "/api/v1/users/#{user.id}/tags/#{tag.id}", params: { tag: invalid_attributes }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users/:user_id/tags/:id' do
    let!(:tag) { create(:tag, user: user) }

    it 'deletes the tag' do
      delete "/api/v1/users/#{user.id}/tags/#{tag.id}", headers: headers
      
      expect(tag.reload.active).to eq(false)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /users/:user_id/tags/public' do
    let!(:public_tags) { create_list(:tag, 3, user: user, is_public: true) }
    it_behaves_like 'fetching tags', :public
  end

  describe 'GET /users/:user_id/tags/private' do
    let!(:private_tags) { create_list(:tag, 2, user: user, is_public: false) }

    it_behaves_like 'fetching tags', :private
  end
end
