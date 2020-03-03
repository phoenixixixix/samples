# frozen_string_literal: true

class FetchMoviesService
  def initialize(current_user, options)
    @current_user = current_user
    @options = options
  end

  def perform
    AttachUserRateToMoviesService.new(movies_query.includes(:genres), current_user_id).perform
  end

  private

  def current_user_id
    @current_user.id if @current_user
  end

  def movies_query
    return Movie.all unless @options[:genre_slug]

    Genre.find_by!(slug: @options[:genre_slug]).movies
  end
end
