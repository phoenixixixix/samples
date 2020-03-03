class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :slug
      t.text :plot
      t.string :poster
      t.decimal :rating, precision: 3, scale: 1, default: 0

      t.timestamps
    end
  end
end
