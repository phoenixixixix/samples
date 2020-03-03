# frozen_string_literal: true

require 'application_integration_test_case'

class UserSignsUpTest < ApplicationIntegrationTestCase
  test 'user signs up successfully' do
    visit '/users/sign_up'

    fill_in 'user[email]', with: 'new_user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Sign up'

    assert_text 'Sign out'
    assert_current_path root_path

    new_user = User.find_by(email: 'new_user@example.com')
    assert_not_nil new_user
    assert_not new_user.admin?
  end
end
