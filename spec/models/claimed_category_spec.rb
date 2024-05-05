require 'rails_helper'

RSpec.describe ClaimedCategory, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  describe 'validations' do
    let(:user2) { create(:user) }
    let(:category2) { create(:category, user: user) }
    let!(:claimed_category) { create(:claimed_category, user: user2, category: category) }

    it 'validates [user_id, category_id] uniqueness' do
      is_expected
        .to validate_uniqueness_of(:user_id)
        .scoped_to(:category_id)
        .with_message('has already claimed this category')
    end

    it 'does not allow a user to claim their own categories' do
      claimed_category = build(:claimed_category, user: user, category: category)
      expect(claimed_category.save).to be_falsey
      expect(claimed_category.errors.full_messages).to include('User cannot claim their own categories')
    end
  end
end
