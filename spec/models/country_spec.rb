require 'rails_helper'
require_relative '../support/shared_examples/validate_locationable_entity'

RSpec.describe Country, type: :model do
  it_behaves_like :validate_locationable_entity, :country
end
