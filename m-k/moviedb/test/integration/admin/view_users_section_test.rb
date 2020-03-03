# frozen_string_literal: true

require 'application_integration_test_case'

class ViewUsersSectionTest < ApplicationIntegrationTestCase
  test 'admin user successfully see users table' do
    sign_in(:admin)

    visit '/admin'
    click_on 'Users'

    assert_text 'Users'
    assert_equal '/admin/users', current_path
  end

  test 'regular user gets redirected to root page' do
    sign_in(:user)

    visit '/admin'

    assert_equal '/', current_path
  end
end
