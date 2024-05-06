class CategoriesRepresenter
  def initialize(categories)
    @categories = categories
  end

  def as_json
    categories.map do |category|
      CategoryRepresenter.new(category).as_json
    end
  end

  private

  attr_reader :categories
end
