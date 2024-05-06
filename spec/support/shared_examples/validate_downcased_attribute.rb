RSpec.shared_examples :validate_downcased_attribute do |model, attribute, upercased_value|
  it 'validates that the attribute was downcased' do
    model_instance = build(model, attribute => upercased_value)
    model_instance.save
    model_instance.reload

    expect(model_instance.send(attribute)).to eq(upercased_value.downcase)
  end
end
