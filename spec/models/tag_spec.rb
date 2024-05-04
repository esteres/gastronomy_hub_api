require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    let!(:tag) { create(:tag) }

    it { should belong_to(:user) }
    it { should have_many(:users_claimed).class_name('ClaimedTag') }
  end

  describe 'validations' do
    let!(:tag) { create(:tag) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should define_enum_for(:priority).with_values([:low, :medium, :high]) }
  end

  describe 'scopes' do
    describe '.active' do
      it 'should only include active tags' do
        active_tags = create_list(:tag, 3, active: true)
        inactive_tag = create(:tag, active: false)

        expect(Tag.active).to match_array(active_tags)
        expect(Tag.active).not_to include(inactive_tag)
      end
    end
  end

  describe 'callbacks' do
    it 'downcases name before saving' do
      tag = create(:tag, name: 'TestTag')
      expect(tag.name).to eq('testtag')
    end
  end
end
