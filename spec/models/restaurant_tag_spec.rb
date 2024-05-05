require 'rails_helper'

RSpec.describe RestaurantTag, type: :model do
  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should belong_to(:tag) }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:tag) { create(:tag, user: user) }
    let!(:restuarant_tag) do
      create(
        :restaurant_tag,
        restaurant: restaurant,
        tag: tag
      )
    end

    it 'validates [restaurant, tag_id] uniqueness' do
      is_expected
        .to validate_uniqueness_of(:restaurant_id)
        .scoped_to(:tag_id)
        .with_message('is already associated with this tag')
    end
  end
end
