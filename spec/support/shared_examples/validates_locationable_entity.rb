require_relative 'downcases_attribute_before_saving'

RSpec.shared_examples :validates_locationable_entity do |model|
  describe 'associations' do
    it { should have_many(:locations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
