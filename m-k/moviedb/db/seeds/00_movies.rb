# frozen_string_literal: true

seed_file = Rails.root.join('db/seeds/fixtures/movies.yml')
movies = YAML.load_file(seed_file)

movies.each do |_imdb_id, data|
  movie = Movie.create!(
    title: data[:title],
    poster: data[:poster],
    plot: data[:plot]
  )

  data[:genres].each do |genre|
    movie.genres << Genre.find_or_create_by(name: genre)
  end
end
