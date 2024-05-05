module Claimable
  extend ActiveSupport::Concern

  included do
    enum priority: { low: 0, medium: 1, high: 2 }

    validates :name, presence: true, length: { maximum: 100 }
    validates_uniqueness_of :name, case_sensitive: false
    validates :priority, inclusion: { in: priorities.keys }

    scope :active, -> { where(active: true) }
  end
end
