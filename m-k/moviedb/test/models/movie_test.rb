# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test 'persists' do
    assert_difference -> { Movie.count } do
      Movie.create(title: 'Robocop', plot: 'cyberpunk action film')
    end
  end

  test 'validates presence of title' do
    movie = Movie.new
    assert_not movie.valid?
    assert_not_empty movie.errors[:title]
  end

  test 'validates presence of plot' do
    movie = Movie.new
    assert_not movie.valid?
    assert_not_empty movie.errors[:plot]
  end

  test 'sets rating to zero by default' do
    movie = Movie.new(title: 'Robocop', plot: 'cyberpunk action film')
    assert movie.save
    assert_equal 0, movie.rating
  end

  test 'generates slug' do
    movie = Movie.new(
      title: 'Terminator 2: Judgment Day',
      plot: 'American science fiction action film'
    )
    assert movie.save
    assert_equal 'terminator-2-judgment-day', movie.slug
  end
end
