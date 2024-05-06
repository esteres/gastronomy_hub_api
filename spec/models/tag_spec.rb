require 'rails_helper'
require_relative '../support/shared_examples/validates_claimable_entity'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    let!(:tag) { create(:tag) }

    it { should belong_to(:user) }
    it { should have_many(:users_claimed).class_name('ClaimedTag') }
  end

  describe 'validations' do
    let!(:tag) { create(:tag) }

    it_behaves_like :validates_claimable_entity, :tag
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
    it_behaves_like :downcases_attribute_before_saving,
      :tag,
      :name, 'TAG NAME'
  end
end
