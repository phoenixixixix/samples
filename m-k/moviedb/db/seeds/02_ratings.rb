# frozen_string_literal: true

User.where(admin: false).each do |user|
  Movie.all.sample(40).each do |movie|
    user.ratings.create!(movie: movie, rate: rand(2..10))
  end
end

Movie.find_each do |movie|
  RecalculateMovieRatingService.new(movie).perform
end
