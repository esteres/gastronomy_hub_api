require_relative 'validate_downcased_attribute'

RSpec.shared_examples :validate_locationable_entity do |model|
  it { should have_many(:locations) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_uniqueness_of(:name).case_insensitive }

  it_behaves_like :validate_downcased_attribute, model, :name, 'NAME'
end
