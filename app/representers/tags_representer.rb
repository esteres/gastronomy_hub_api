class TagsRepresenter
  def initialize(tags)
    @tags = tags
  end

  def as_json
    tags.map do |tag|
      TagRepresenter.new(tag).as_json
    end
  end

  private

  attr_reader :tags
end
