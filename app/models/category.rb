class Category < ApplicationRecord
  include SharedMethods
  include Claimable

  belongs_to :user

  has_many :restaurant_categories
  has_many :restaurants, through: :restaurant_categories
  has_many :users_claimed, class_name: 'ClaimedCategory'

  validates :icon_url,
    format: { 
      with: /\Ahttps?:\/\/.*\z/,
      message: 'must be a valid URL'
    },
    allow_blank: true,
    length: { maximum: 255 }

  def initialize(*args)
    @downcase_field = :name

    super
  end
end
