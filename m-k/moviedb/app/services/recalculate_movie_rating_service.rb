# frozen_string_literal: true

class RecalculateMovieRatingService
  def initialize(movie)
    @movie = movie
  end

  def perform
    @movie.update!(rating: @movie.ratings.average(:rate))
    ActionCable.server.broadcast 'movie_rating_channel', @movie.slice(:id, :rating)
  end
end
