class ClaimedTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  validates :user_id,
    uniqueness: { scope: :tag_id, message: 'has already claimed this tag' }
  validate :user_cannot_claim_own_tags, if: -> { user.present? && tag.present? }
  
  def user_cannot_claim_own_tags
    if user.id == tag.user.id
      errors.add(:base, 'User cannot claim their own tags')
    end
  end
end
