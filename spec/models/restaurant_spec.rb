require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'associations' do
     it { should have_many(:restaurant_categories).dependent(:destroy) }
     it { should have_many(:categories).through(:restaurant_categories) }
     it { should have_many(:restaurant_tags).dependent(:destroy) }
     it { should have_many(:tags).through(:restaurant_tags) }
  end

  describe 'validations' do
    let!(:restaurant) { create(:restaurant) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should define_enum_for(:contact_information_type).with_values([:phone, :email]) }
    it { should validate_length_of(:contact_information).is_at_most(100) }
    
    context 'when contact information is an email' do
      before { subject.contact_information_type = :email }

      it { should allow_value('test@example.com').for(:contact_information) }
      it { should_not allow_value('invalid_email').for(:contact_information) }
    end
    
    context 'when contact information is a phone number' do
      before { subject.contact_information_type = :phone }

      it { should allow_value('8789797').for(:contact_information) }
      it { should_not allow_value('not_a_number').for(:contact_information) }
    end
  end
end
