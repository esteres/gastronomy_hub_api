class RestaurantTag < ApplicationRecord
  belongs_to :restaurant
  belongs_to :tag, inverse_of: :restaurant_tags

  validates :restaurant_id,
  uniqueness: { scope: :tag_id, message: 'is already associated with this tag' }
end
