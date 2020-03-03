# frozen_string_literal: true

require 'test_helper'

class MovieRatingChannelTest < ActionCable::Channel::TestCase
  test 'subscribes' do
    subscribe
    assert subscription.confirmed?
  end

  test 'broadcasts to the stream' do
    assert_broadcasts('movie_rating_channel', 1) do
      ActionCable.server.broadcast 'movie_rating_channel', text: 'hello'
    end
  end

  test 'does not broadcast from another stream' do
    assert_no_broadcasts('movie_rating_channel') do
      ActionCable.server.broadcast 'user_rating_channel', text: 'hello'
    end
  end
end
