# frozen_string_literal: true

require 'test_helper'

class RecalculateMovieRatingServiceTest < ActiveSupport::TestCase
  include ActionCable::TestHelper

  test 'updates movie rating' do
    movie = Movie.create!(title: 'Robocop', plot: 'cyberpunk action film')
    movie.ratings.create!(user: users(:admin), rate: 8)
    movie.ratings.create!(user: users(:user), rate: 5)
    assert_equal 0, movie.rating

    RecalculateMovieRatingService.new(movie).perform

    assert_broadcasts 'movie_rating_channel', 1
    assert_equal 6.5, movie.rating
  end
end
