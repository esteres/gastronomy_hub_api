class TagRepresenter
  delegate :id, :name, :description,
    :icon_url, :priority, :active, :is_public, to: :tag

  def initialize(tag)
    @tag = tag
  end

  def as_json
    {
      id: id,
      name: name,
      description: description,
      priority: priority,
      active: active,
      is_public: is_public
    }
  end

  private
  
  attr_reader :tag
end
