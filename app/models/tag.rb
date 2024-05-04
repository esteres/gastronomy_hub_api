class Tag < ApplicationRecord
  include SharedMethods
  include Claimable

  belongs_to :user

  has_many :users_claimed, class_name: 'ClaimedTag'
end
