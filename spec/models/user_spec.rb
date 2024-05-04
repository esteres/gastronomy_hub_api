require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'associations' do
    it { should have_many(:tags_created).class_name('Tag') }
    it { should have_many(:claimed_tags).dependent(:destroy) }
  end

  describe 'validations' do
    it 'validates email uniqueness' do
      should validate_uniqueness_of(:email)
        .case_insensitive.with_message('is already associated with an existing user')
    end
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email).with_message('is invalid. Please enter a valid email address') }
    it { should validate_length_of(:email).is_at_most(255) }

    it 'validates password format' do
      user = User.new(email: 'test@example.com')
      user.password = 'invalid'
      expect(user).not_to be_valid
      expect(user.errors[:password])
        .to include(
          'must contain at least 10 characters, one lowercase letter, ' \
          'one uppercase letter, and one of the following characters: !, @, #, ?, or ]'
        )

      user.password = 'ValidPassword123!'
      expect(user).to be_valid
    end

    it { should have_secure_password }
  end

  describe 'scopes' do
    describe '.tags_created' do
      it 'returns tags created by the user' do
        user = create(:user)
        tag1 = create(:tag, user_id: user.id)
        tag2 = create(:tag)

        expect(user.tags_created).to include(tag1)
        expect(user.tags_created).not_to include(tag2)
      end
    end
  end
end