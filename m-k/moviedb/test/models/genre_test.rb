# frozen_string_literal: true

require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  test 'persists' do
    assert_difference -> { Genre.count } do
      Genre.create(name: 'Art')
    end
  end

  test 'validates presence of name' do
    genre = Genre.new
    assert_not genre.valid?
    assert_not_empty genre.errors[:name]
  end

  test 'validates uniquiness of name' do
    assert Genre.create(name: 'sci-fi')
    genre = Genre.new(name: 'sci-fi')
    assert_not genre.valid?
    assert_includes genre.errors[:name], 'has already been taken'
  end

  test 'generates slug' do
    genre = Genre.new(name: 'Sci-fi')
    assert genre.save
    assert_equal 'sci-fi', genre.slug
  end
end
