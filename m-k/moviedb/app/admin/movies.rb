# frozen_string_literal: true

ActiveAdmin.register Movie do
  permit_params :title, :slug, :plot, :poster, :rating, genre_ids: []
  includes :genres

  controller do
    defaults finder: :find_by_slug
  end

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column(:genres) { |movie| movie.genres.map(&:name) }
    column(:plot) { |movie| movie.plot.truncate(120, separator: /\s/) }
    column :poster
    column :rating
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row(:genres) { |movie| movie.genres.map(&:name) }
      row :plot
      row :poster
      row :rating
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :slug
      f.input :plot
      f.input :genres, as: :check_boxes, multiple: true, collection: Genre.order(name: :asc)
      f.input :poster
      f.input :rating
    end

    f.actions
  end
end
