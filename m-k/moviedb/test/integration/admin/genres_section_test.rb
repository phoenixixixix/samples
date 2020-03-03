# frozen_string_literal: true

require 'application_integration_test_case'

class GenresSectionTest < ApplicationIntegrationTestCase
  test 'admin opens genre show page with details' do
    sign_in(:admin)

    visit '/admin'
    click_on 'Genres'

    assert_text 'Genres'

    row = find(:xpath, ".//tr[./td[text()='Drama']]")
    within row do
      click_on 'View'
    end

    assert_text 'Drama'
    assert_text 'drama'
  end

  test 'admin adds a new genre' do
    sign_in(:admin)

    visit '/admin/genres'
    click_on 'New Genre'

    fill_in 'genre[name]', with: 'Comedy'
    fill_in 'genre[slug]', with: 'fun'

    click_on 'Create Genre'

    genre = Genre.find_by(slug: 'fun')
    assert_equal 'Comedy', genre.name
    assert_equal 'fun', genre.slug
  end

  test 'admin edits a genre' do
    sign_in(:admin)

    visit '/admin/genres'

    row = find(:xpath, ".//tr[./td[text()='Drama']]")
    within row do
      click_on 'Edit'
    end

    fill_in 'genre[name]', with: 'Comedy'
    fill_in 'genre[slug]', with: 'fun'

    click_on 'Update Genre'

    genre = Genre.find_by(slug: 'fun')
    assert_equal 'Comedy', genre.name
    assert_equal 'fun', genre.slug

    assert_not Genre.exists?(slug: 'drama')
  end

  test 'admin deletes a genre' do
    sign_in(:admin)

    visit '/admin/genres'

    row = find(:xpath, ".//tr[./td[text()='Drama']]")
    within row do
      click_on 'Delete'
    end
    page.accept_alert

    assert_text 'Genre was successfully destroyed.'
    assert_not Genre.exists?(slug: 'drama')
  end
end
