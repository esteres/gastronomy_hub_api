module SharedMethods
  extend ActiveSupport::Concern

  included do
    before_save do
       self[downcase_field].downcase!
    end
  end

  attr_accessor :downcase_field
end
