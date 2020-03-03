# frozen_string_literal: true

require 'application_integration_test_case'

class MoviesSectionTest < ApplicationIntegrationTestCase
  test 'admin opens movie show page with movie details' do
    sign_in(:admin)

    visit '/admin'
    click_on 'Movies'

    assert_text 'Movies'

    row = find(:xpath, ".//tr[./td[text()='The Godfather']]")
    within row do
      click_on 'View'
    end

    assert_text 'The Godfather'
    assert_text 'the-godfather'
    assert_text 'The Godfather description'
    assert_text 'Crime, Drama'
  end

  test 'admin edits a movie' do
    sign_in(:admin)

    visit '/admin/movies'

    row = find(:xpath, ".//tr[./td[text()='The Godfather']]")
    within row do
      click_on 'Edit'
    end

    fill_in 'movie[title]', with: 'The New Godfather'
    fill_in 'movie[slug]', with: 'the-new'
    fill_in 'movie[plot]', with: 'Brand new plot'
    find("input[value='#{genres(:western).id}']").set(true)

    click_on 'Update Movie'

    movie = Movie.find_by(slug: 'the-new')
    assert_equal 'The New Godfather', movie.title
    assert_equal 'the-new', movie.slug
    assert_equal 'Brand new plot', movie.plot
    assert_equal %w[Crime Drama Western], movie.genres.map(&:name).sort
  end

  test 'admin adds a new movie' do
    sign_in(:admin)

    visit '/admin/movies'
    click_on 'New Movie'

    fill_in 'movie[title]', with: 'The New Godfather'
    fill_in 'movie[slug]', with: 'the-new'
    fill_in 'movie[plot]', with: 'Brand new plot'
    find("input[value='#{genres(:western).id}']").set(true)

    click_on 'Create Movie'

    new_movie = Movie.find_by(slug: 'the-new')
    assert_equal 'The New Godfather', new_movie.title
    assert_equal 'Brand new plot', new_movie.plot
    assert_equal %w[Western], new_movie.genres.map(&:name).sort
  end

  test 'admin deletes a movie' do
    sign_in(:admin)

    visit '/admin/movies'

    row = find(:xpath, ".//tr[./td[text()='The Godfather']]")
    within row do
      click_on 'Delete'
    end
    page.accept_alert

    assert_text 'Movie was successfully destroyed.'
    assert_not Movie.exists?(slug: 'the-godfather')
  end
end
