# frozen_string_literal: true

require 'test_helper'

class UserRatingChannelTest < ActionCable::Channel::TestCase
  include Warden::Test::WardenHelpers
  test 'reject guests' do
    subscribe
    assert_not subscription.confirmed?
  end

  test 'subscribes logged in users' do
    stub_connection(current_user: user)
    subscribe
    assert subscription.confirmed?
  end

  test 'broadcasts to the user' do
    stub_connection(current_user: user)
    assert_broadcast_on(user, text: 'hello') do
      UserRatingChannel.broadcast_to user, text: 'hello'
    end
  end

  test 'does not broadcast from another user' do
    stub_connection(current_user: user)
    assert_no_broadcasts(users(:admin)) do
      UserRatingChannel.broadcast_to user, text: 'hello'
    end
  end

  private

  def user
    users(:user)
  end
end
