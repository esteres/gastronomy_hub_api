class ClaimedCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user_id,
    uniqueness: { scope: :category_id, message: 'has already claimed this category' }
  validate :user_cannot_claim_own_categories, if: -> { user.present? && category.present? }
  
  def user_cannot_claim_own_categories
    if user.id == category.user.id
      errors.add(:base, 'User cannot claim their own categories')
    end
  end
end
