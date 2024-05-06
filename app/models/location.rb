class Location < ApplicationRecord
include DowncaseAttributes

  belongs_to :restaurant
  belongs_to :city
  belongs_to :state
  belongs_to :country

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :zip_code, length: { maximum: 50 }, if: -> { zip_code.present? }
  
  validate :unique_name_and_address_combination,
    if: -> { name.present? && address.present? }

  downcase_attributes :name, :address

  private

  def unique_name_and_address_combination
    if Location.where(
      'address = ? AND name = ?',
      address.downcase,
      name.downcase
    ).any?
      errors.add(:address, "and name combination must be unique")
    end
  end
end
