# frozen_string_literal: true

class RateMovieJob < ApplicationJob
  queue_as :default

  def perform(movie_id, user_id, rate)
    movie = Movie.find_by(id: movie_id)
    user = User.find_by(id: user_id)
    return unless movie && user

    RateMovieService.new(movie, user, rate).perform
  end
end
