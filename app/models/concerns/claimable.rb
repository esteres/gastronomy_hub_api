module Claimable
  extend ActiveSupport::Concern
  include DowncaseAttributes

  included do
    enum priority: { low: 0, medium: 1, high: 2 }

    validates :name, presence: true, length: { maximum: 100 }
    validates_uniqueness_of :name, case_sensitive: false
    validates :priority, inclusion: { in: priorities.keys }

    # get those records that the user didn't soft delete already
    scope :active, -> { where(active: true) }

    scope :public_ones, -> { where(is_public: true) }

    downcase_attributes :name
  end
end
