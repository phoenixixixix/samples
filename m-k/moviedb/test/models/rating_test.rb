# frozen_string_literal: true

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test 'persists' do
    assert_difference -> { Rating.count } do
      Rating.create(rate: 10, movie: movies(:good_bad_ugly), user: users(:user))
    end
  end

  test 'requires associated movie' do
    rating = Rating.new
    assert_not rating.valid?
    assert_includes rating.errors[:movie], 'must exist'
  end

  test 'requires associated user' do
    rating = Rating.new
    assert_not rating.valid?
    assert_includes rating.errors[:user], 'must exist'
  end

  test 'restricts rate above 10' do
    rating = Rating.new(rate: 14)
    assert_not rating.valid?
    assert_includes rating.errors[:rate], 'is not included in the list'
  end

  test 'restricts rate below 1' do
    rating = Rating.new(rate: 0)
    assert_not rating.valid?
    assert_includes rating.errors[:rate], 'is not included in the list'
  end
end
