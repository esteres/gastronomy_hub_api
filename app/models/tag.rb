class Tag < ApplicationRecord
  include SharedMethods

  belongs_to :user

  has_many :users_claimed, class_name: 'ClaimedTag'

  enum priority: { low: 0, medium: 1, high: 2 }

  validates :name, presence: true, length: { maximum: 100 }
  validates_uniqueness_of :name, case_sensitive: false
  validates :priority, inclusion: { in: priorities.keys }

  scope :active, -> { where(active: true) }

  def initialize(*args)
    @downcase_field = :name

    super
  end
end
