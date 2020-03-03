# frozen_string_literal: true

class RateMovieService
  def initialize(movie, user, rate)
    @movie = movie
    @user = user
    @rate = rate
  end

  def perform
    rating = Rating.find_or_initialize_by(movie: @movie, user: @user)
    rating.update!(rate: @rate)
    UserRatingChannel.broadcast_to(@user, rating.slice(:movie_id, :rate))
    RecalculateMovieRatingService.new(@movie).perform
  end
end
