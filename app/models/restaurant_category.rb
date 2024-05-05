class RestaurantCategory < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category

  validates :restaurant_id,
    uniqueness: { scope: :category_id, message: 'is already associated with this category' }
end
