require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    let!(:category) { create(:category) }

    it { should belong_to(:user) }
    it { should have_many(:users_claimed).class_name('ClaimedCategory') }
  end

  describe 'validations' do
    let!(:category) { create(:category) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should define_enum_for(:priority).with_values([:low, :medium, :high]) }

    context 'with icon_url' do
      let(:icon_url) { 'https://example.com/icon.png' }

      subject { build(:category, icon_url: icon_url) }

      context 'with a valid icon_url' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'with an invalid icon_url' do
        let(:icon_url) { 'invalid_url' }

        it 'is not valid' do
          expect(subject).not_to be_valid
        end

        it 'adds an error message' do
          subject.valid?
          expect(subject.errors[:icon_url]).to include('must be a valid URL')
        end
      end

      context 'with a too long icon_url' do
        let(:icon_url) { 'https://example.com/' + 'a' * 300 }

        it 'is not valid' do
          expect(subject).not_to be_valid
        end

        it 'adds an error message' do
          subject.valid?
          expect(subject.errors[:icon_url]).to include('is too long (maximum is 255 characters)')
        end
      end

      context 'with a blank icon_url' do
        let(:icon_url) { nil }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end
  end

  describe 'scopes' do
    describe '.active' do
      it 'should only include active categories' do
        active_categories = create_list(:category, 3, active: true)
        inactive_categories = create(:category, active: false)

        expect(Category.active).to match_array(active_categories)
        expect(Category.active).not_to include(inactive_categories)
      end
    end
  end

  describe 'callbacks' do
    it 'downcases name before saving' do
      category = create(:category, name: 'TestCategory')
      expect(category.name).to eq('testcategory')
    end
  end
end
