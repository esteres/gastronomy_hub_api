module Locationable
  extend ActiveSupport::Concern
  include DowncaseAttributes

  included do
    has_many :locations

    validates :name, presence: true, length: { maximum: 100 }
    validates_uniqueness_of :name, case_sensitive: false

    downcase_attributes :name
  end
end
