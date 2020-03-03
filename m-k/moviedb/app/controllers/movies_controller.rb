# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: :update

  def index
    @genres = Genre.order(name: :asc)
    @movies = fetch_movies(index_params).order(title: :asc).page(params[:page])
  end

  def show
    @movie = fetch_movies.find_by(slug: params[:id])
  end

  def update
    @movie = Movie.find_by(slug: params[:id])
    RateMovieJob.perform_later(@movie.id, current_user.id, update_params)
    head :ok
  end

  private

  def index_params
    params.permit(:genre_slug)
  end

  def update_params
    params.require(:rate)
    params[:rate]
  end

  def fetch_movies(options = {})
    FetchMoviesService.new(current_user, options).perform
  end
end
