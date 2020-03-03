# frozen_string_literal: true

class Movie < ApplicationRecord
  include Slugged.new(source: :title)

  has_and_belongs_to_many :genres
  has_many :ratings, dependent: :destroy

  validates :title, :plot, presence: true
end
