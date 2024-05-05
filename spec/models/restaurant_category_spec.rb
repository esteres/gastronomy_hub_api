require 'rails_helper'

RSpec.describe RestaurantCategory, type: :model do
  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should belong_to(:category) }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:category) { create(:category, user: user) }
    let!(:restaurant_category) do
      create(
        :restaurant_category,
        restaurant: restaurant,
        category: category
      )
    end

    it 'validates [restaurant, category_id] uniqueness' do
      is_expected
        .to validate_uniqueness_of(:restaurant_id)
        .scoped_to(:category_id)
        .with_message('is already associated with this category')
    end
  end
end
