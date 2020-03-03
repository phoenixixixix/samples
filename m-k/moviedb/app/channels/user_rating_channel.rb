# frozen_string_literal: true

class UserRatingChannel < ApplicationCable::Channel
  def subscribed
    if defined?(current_user) && current_user.present?
      stream_for(current_user)
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
