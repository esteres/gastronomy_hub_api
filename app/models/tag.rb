class Tag < ApplicationRecord
  include Claimable

  belongs_to :user

  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags
  has_many :users_claimed, class_name: 'ClaimedTag'
end
