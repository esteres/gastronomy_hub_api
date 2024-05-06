require 'rails_helper'
require_relative '../support/shared_examples/validate_downcased_attribute'

RSpec.describe Location, type: :model do
  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should belong_to(:city) }
    it { should belong_to(:state) }
    it { should belong_to(:country) }
  end

  describe 'validations' do
    subject { build(:location) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_most(255) }
    it { should validate_length_of(:zip_code).is_at_most(50).allow_nil }
    
    it_behaves_like :validate_downcased_attribute, :location, :name, 'LOCATION NAME'

    context 'when zip_code is present' do
      subject { build(:location, zip_code: '12345') }

      it { should validate_length_of(:zip_code).is_at_most(50) }
    end

    context 'when zip_code is not present' do
      subject { build(:location, zip_code: nil) }

      it { should_not validate_presence_of(:zip_code) }
    end

    describe '#unique_name_and_address_combination' do
      let!(:existing_location) { create(:location) }

      context 'with a unique name and address combination' do
        it 'is valid' do
          location = build(:location)
          expect(location).to be_valid
        end
      end

      context 'with a non-unique name and address combination' do
        it 'is not valid' do
          location = build(
            :location,
            address: existing_location.address,
            name: existing_location.name
          )
          expect(location).not_to be_valid
          expect(location.errors[:address])
            .to include("and name combination must be unique")
        end
      end
    end
  end
end
