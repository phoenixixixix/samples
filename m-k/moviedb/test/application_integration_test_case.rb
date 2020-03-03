# frozen_string_literal: true

require 'test_helper'

class ApplicationIntegrationTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  Capybara.server = :puma, { Silent: true }

  def sign_in(user)
    visit '/users/sign_in'

    fill_in 'user[email]', with: users(user).email
    fill_in 'user[password]', with: 'password'
    click_on 'Log in'
  end
end
