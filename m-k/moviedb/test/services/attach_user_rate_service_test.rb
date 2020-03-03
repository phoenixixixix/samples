# frozen_string_literal: true

require 'test_helper'

class AttachUserRateServiceTest < ActiveSupport::TestCase
  QUERY = Movie.all

  test 'returns movies with user rate' do
    user = users(:user)
    movie = movies(:good_bad_ugly)
    user.ratings.create!(movie: movie, rate: 8)

    result = AttachUserRateToMoviesService.new(QUERY, user.id).perform.find_by(id: movie.id)

    assert_equal 8, result.rate
  end

  test 'returns movies with nil as user rate for anonymous users' do
    user = users(:user)
    movie = movies(:good_bad_ugly)
    user.ratings.create!(movie: movie, rate: 8)

    result = AttachUserRateToMoviesService.new(QUERY, nil).perform.find_by(id: movie.id)

    assert_nil result.rate
  end

  test 'returns all movies' do
    user = users(:user)
    movie = movies(:good_bad_ugly)
    user.ratings.create!(movie: movie, rate: 8)

    result = AttachUserRateToMoviesService.new(QUERY, user.id).perform

    assert_equal Movie.count, result.size
  end
end
