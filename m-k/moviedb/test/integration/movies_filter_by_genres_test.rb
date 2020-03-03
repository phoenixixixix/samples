# frozen_string_literal: true

require 'application_integration_test_case'

class MoviesFilterByGenresTest < ApplicationIntegrationTestCase
  test 'user sees genres filter' do
    visit '/'

    within find('.moviedb-genres-filter') do
      assert_text 'Crime'
      assert_text 'Drama'
      assert_text 'Western'
    end
  end

  test 'initially user sees all unfiltered movies' do
    visit '/'

    assert_text 'Pulp Fiction'
    assert_text 'The Good, the Bad and the Ugly'
  end

  test 'user filters movie by a genre' do
    visit '/'

    within find('.moviedb-genres-filter') do
      click_on 'Western'
    end

    assert_text 'The Good, the Bad and the Ugly'
    assert_no_text 'Pulp Fiction'
  end
end
