module Claimable
  extend ActiveSupport::Concern

  included do
    validate :user_cannot_claim_own_tags
  end

  private

  def user_cannot_claim_own_tags
    if user == tag.creator
      errors.add(:base, "User cannot claim their own #{tag.class.name.downcase}s")
    end
  end
end
