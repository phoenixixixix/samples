class CreateGenresMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :genres_movies do |t|
      t.references :genre, foreign_key: { on_delete: :cascade }, index: true
      t.references :movie, foreign_key: { on_delete: :cascade }, index: true
    end
  end
end
