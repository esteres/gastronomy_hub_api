class CategoryRepresenter
  delegate :id, :name, :description,
    :icon_url, :priority, :active, :is_public, to: :category

  def initialize(category)
    @category = category
  end

  def as_json
    {
      id: id,
      name: name,
      description: description,
      icon_url: icon_url,
      priority: priority,
      active: active,
      is_public: is_public
    }
  end

  private
  
  attr_reader :category
end
