module DowncaseAttributes
  extend ActiveSupport::Concern

  included do
    before_save do
      self.class.downcase_attributes&.each do |attribute|
        self[attribute].downcase! if self[attribute].present?
      end
    end

    class << self
      def downcase_attributes(*attributes)
        @downcase_attributes ||= attributes
      end
    end
  end
end
