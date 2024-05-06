class Review < ApplicationRecord
  include DowncaseAttributes

  belongs_to :user
  belongs_to :restaurant
  
  validates :user_id, uniqueness: {
    scope: :restaurant_id,
    message: 'has already submitted a review for this restaurant'
  }
  validates :title, presence: true, length: { maximum: 100 }
  validates :visit_date, presence: true
  validates :rating,
	  presence: true,
	  numericality: {
		  only_integer: true,
		  greater_than_or_equal_to: 1,
		  less_than_or_equal_to: 5,
		  allow_nil: false
		}
	validates :ambience_rating,
	  numericality: {
		  only_integer: true,
		  greater_than_or_equal_to: 1,
		  less_than_or_equal_to: 5,
		  allow_nil: true
		}
	validates :service_rating,
	  numericality: {
		  only_integer: true,
		  greater_than_or_equal_to: 1,
		  less_than_or_equal_to: 5,
		  allow_nil: true
		}
  validates :wait_time,
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: 0,
			message: 'must be a non-negative integer representing minutes',
			allow_nil: true
		}

  validate :validate_visit_date, unless: -> { visit_date.blank? }

  downcase_attributes :title

  private

  def validate_visit_date
    visit_date_date = Date.parse(visit_date.to_s)

    if visit_date_date > Date.today
      errors.add(:visit_date, "cannot be in the future")
    end
  end
end
