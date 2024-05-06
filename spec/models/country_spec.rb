require 'rails_helper'
require_relative '../support/shared_examples/validates_locationable_entity'

RSpec.describe Country, type: :model do
  it_behaves_like :validates_locationable_entity, :country

  describe 'callbacks' do
    it_behaves_like :downcases_attribute_before_saving,
      :country,
      :name, 'COUNTRY NAME'
  end
end
