# frozen_string_literal: true

require 'application_integration_test_case'

class UserSignsInTest < ApplicationIntegrationTestCase
  test 'user signs in successfully' do
    visit '/users/sign_in'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'

    click_on 'Log in'

    assert_text 'Sign out'
    assert_current_path root_path
  end
end
