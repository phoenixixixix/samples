# frozen_string_literal: true

class Genre < ApplicationRecord
  include Slugged.new

  has_and_belongs_to_many :movies

  validates :name, presence: true, uniqueness: true
end
