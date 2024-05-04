class User < ApplicationRecord
  include SharedMethods

  has_many :categories_created,
		-> { active },
		class_name: 'Category'
  has_many :tags_created,
    -> { active },
		class_name: 'Tag'
  has_many :claimed_categories, dependent: :destroy
  has_many :claimed_tags, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#?])[a-zA-Z\d!@#?]{10,}\z/

  has_secure_password
  
  validates :email,
	  format: {
		  with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
		  message: 'is invalid. Please enter a valid email address'
		},
	  length: { maximum: 255 }
  validates_uniqueness_of :email,
    case_sensitive: false,
    message: 'is already associated with an existing user'
	validates :password,
		format: {
			with: PASSWORD_REGEX,
			message: 'must contain at least 10 characters, ' \
								'one lowercase letter, one uppercase letter, ' \
								'and one of the following characters: !, @, #, ?, or ]'
		}, on: %i[create update]

  def initialize(*args)
    @downcase_field = :email

    super
  end
end
