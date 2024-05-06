RSpec.shared_examples :downcases_attribute_before_saving do |model, attribute, upercased_value|
  it 'downcases the title before saving' do
    model_instance = build(model, attribute => upercased_value)
    model_instance.save
    model_instance.reload

    expect(model_instance.send(attribute)).to eq(upercased_value.downcase)
  end
end
