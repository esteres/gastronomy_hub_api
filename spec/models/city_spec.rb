require 'rails_helper'
require_relative '../support/shared_examples/validates_locationable_entity'

RSpec.describe City, type: :model do
  it_behaves_like :validates_locationable_entity, :city

  describe 'callbacks' do
    it_behaves_like :downcases_attribute_before_saving,
      :city,
      :name, 'CITY NAME'
  end
end
