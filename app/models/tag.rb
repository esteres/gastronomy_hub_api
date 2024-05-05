class Tag < ApplicationRecord
  include SharedMethods
  include Claimable

  belongs_to :user

  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags
  has_many :users_claimed, class_name: 'ClaimedTag'

  def initialize(*args)
    @downcase_field = :name

    super
  end
end
