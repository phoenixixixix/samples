# frozen_string_literal: true

require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    get root_path
    assert_equal 200, status
  end

  test '#index returns not_found for non existent genre' do
    assert_raises ActiveRecord::RecordNotFound do
      get genre_movies_path('nonExistent')
    end
  end

  test '#show' do
    movie = Movie.create!(
      title: 'Robocop', plot: 'cyberpunk action film', poster: 'https://exam.ple/img.jpg'
    )
    get movie_path(movie)
    assert_equal 200, status
  end

  test '#update restricted for guests' do
    movie = Movie.create!(
      title: 'Robocop', plot: 'cyberpunk action film', poster: 'https://exam.ple/img.jpg'
    )
    patch movie_path(movie)
    assert_equal 302, status
    follow_redirect!
    assert_equal new_user_session_path, path
  end

  test '#update requires rate parameter' do
    login_as(users(:user))
    movie = Movie.create!(
      title: 'Robocop', plot: 'cyberpunk action film', poster: 'https://exam.ple/img.jpg'
    )
    assert_raises ActionController::ParameterMissing do
      patch movie_path(movie)
    end
  end

  test '#update enqueues background job' do
    user = users(:user)
    login_as(user)
    movie = Movie.create!(
      title: 'Robocop', plot: 'cyberpunk action film', poster: 'https://exam.ple/img.jpg'
    )

    assert_enqueued_with(
      job: RateMovieJob, args: [movie.id, user.id, '8'], queue: 'default'
    ) do
      patch movie_path(movie, rate: 8)
    end

    assert_equal 200, status
  end
end
