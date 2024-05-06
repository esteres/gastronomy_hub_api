require 'rails_helper'
require_relative '../support/shared_examples/downcases_attribute_before_saving'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:restaurant) }
  end

  describe 'validations' do
    subject { build(:review) }

    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
    it { should validate_presence_of(:visit_date) }
    it 'validates uniqueness of user within scope of restaurant' do
      should validate_uniqueness_of(:user_id)
        .scoped_to(:restaurant_id)
        .with_message('has already submitted a review for this restaurant')
    end

    it "adds an error when visit date is in the future" do
      review = build(:review, visit_date: Date.tomorrow)
      review.valid?
      expect(review.errors[:visit_date]).to include("cannot be in the future")
    end

    it "does not add an error when visit date is valid" do
      review = build(:review, visit_date: Date.today)
      review.valid?
      expect(review.errors[:visit_date]).to be_empty
    end

    it 'validates rating presence' do
      should validate_numericality_of(:rating)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
    end

    it 'validates ambience rating' do
      should validate_numericality_of(:ambience_rating)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
        .allow_nil
    end

    it 'validates service rating' do
      should validate_numericality_of(:service_rating)
        .only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
        .allow_nil
    end

    it 'validates wait time' do
      should validate_numericality_of(:wait_time)
        .only_integer
        .is_greater_than_or_equal_to(0)
        .with_message('must be a non-negative integer representing minutes')
        .allow_nil
    end
  end

  describe 'callbacks' do
    it_behaves_like :downcases_attribute_before_saving,
      :review,
      :title, 'REVIEW TITLE'
  end
end
