# frozen_string_literal: true

require 'test_helper'

class RateMovieJobTest < ActiveJob::TestCase
  test 'ignores non existing user' do
    assert_nothing_raised do
      RateMovieJob.perform_now(movie.id, User.maximum(:id).next, 8)
    end
  end

  test 'ignores non existing movie' do
    assert_nothing_raised do
      RateMovieJob.perform_now(Movie.maximum(:id).next, user.id, 8)
    end
  end

  test 'creates user rating' do
    assert_difference -> { Rating.count } do
      RateMovieJob.perform_now(movie.id, user.id, 8)
    end
  end

  test 'updates user rating' do
    rating = user.ratings.create!(movie: movie, rate: 2)
    assert_no_difference -> { Rating.count } do
      RateMovieJob.perform_now(movie.id, user.id, 8)
    end
    assert_equal 8, rating.reload.rate
  end

  private

  def user
    users(:user)
  end

  def movie
    movies(:good_bad_ugly)
  end
end
