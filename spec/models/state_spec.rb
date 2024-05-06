require 'rails_helper'
require_relative '../support/shared_examples/validates_locationable_entity'

RSpec.describe State, type: :model do
  it_behaves_like :validates_locationable_entity, :state

  describe 'callbacks' do
    it_behaves_like :downcases_attribute_before_saving,
      :state,
      :name, 'STATE NAME'
  end
end
