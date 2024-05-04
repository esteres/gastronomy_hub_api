require 'rails_helper'

RSpec.describe ClaimedTag, type: :model do
  let!(:user) { create(:user) }
  let!(:tag) { create(:tag, user: user) }

  describe 'validations' do
    let!(:user2) { create(:user) }
    let!(:tag2) { create(:tag, user: user) }
    let!(:claimed_tag) { create(:claimed_tag, user: user2, tag: tag) }

    it 'validates [user_id, tag_id] uniqueness' do
      is_expected
        .to validate_uniqueness_of(:user_id)
        .scoped_to(:tag_id)
        .with_message('has already claimed this tag')
    end

    it 'does not allow a user to claim their own tags' do
      claimed_tag = build(:claimed_tag, user: user, tag: tag)
      expect(claimed_tag.save).to be_falsey
      expect(claimed_tag.errors.full_messages).to include('User cannot claim their own tags')
    end
  end
end
