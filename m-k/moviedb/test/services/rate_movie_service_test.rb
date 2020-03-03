# frozen_string_literal: true

require 'test_helper'

class RateMovieServiceTest < ActiveSupport::TestCase
  test 'creates user rating' do
    user = users(:user)
    movie = Movie.create!(title: 'Robocop', plot: 'cyberpunk action film')

    assert_difference -> { Rating.count } do
      RateMovieService.new(movie, user, 10).perform
    end

    assert_equal 10, user.ratings.find_by(movie: movie).rate
  end

  test 'updates existing user rating' do
    user = users(:user)
    movie = Movie.create!(title: 'Robocop', plot: 'cyberpunk action film')
    rating = movie.ratings.create!(user: user, rate: 5)

    assert_no_difference -> { Rating.count } do
      RateMovieService.new(movie, user, 10).perform
    end

    assert_equal 10, rating.reload.rate
  end
end
