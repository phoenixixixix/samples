# frozen_string_literal: true

class MovieRatingChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'movie_rating_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
