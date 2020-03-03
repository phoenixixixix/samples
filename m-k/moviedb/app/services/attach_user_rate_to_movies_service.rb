# frozen_string_literal: true

class AttachUserRateToMoviesService
  MOVIES_TABLE = Movie.arel_table
  RATINGS_TABLE = Rating.arel_table

  def initialize(query, current_user_id)
    @query = query
    @current_user_id = current_user_id
  end

  def perform
    @query.joins(user_ratings_join_sources).select(MOVIES_TABLE[Arel.star], select_rate)
  end

  private

  def select_rate
    return 'null as rate' unless @current_user_id

    RATINGS_TABLE[:rate].as('rate')
  end

  def user_ratings_join_sources
    return unless @current_user_id

    MOVIES_TABLE.outer_join(RATINGS_TABLE).on(
      MOVIES_TABLE[:id].eq(RATINGS_TABLE[:movie_id]).and(
        RATINGS_TABLE[:user_id].eq(@current_user_id)
      )
    ).join_sources
  end
end
