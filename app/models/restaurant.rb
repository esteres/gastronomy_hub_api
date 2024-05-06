class Restaurant < ApplicationRecord
  include DowncaseAttributes

  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories

  has_many :restaurant_tags, dependent: :destroy
  has_many :tags, through: :restaurant_tags

  has_many :locations, dependent: :destroy

  enum contact_information_type: {
    phone: 0,
    email: 1
  }

  validates :name, presence: true, length: { maximum: 100 }
  validates_uniqueness_of :name, case_sensitive: false
  validates :contact_information_type, inclusion: { in: contact_information_types.keys, allow_nil: true }
  validates :contact_information, length: { maximum: 100 }

  validates :contact_information, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, if: -> { email? }
  validates :contact_information, format: { with: /\A\d+\z/ }, if: -> { phone? }

  downcase_attributes :name, :contact_information, if: -> { email? }
  downcase_attributes :name
end
