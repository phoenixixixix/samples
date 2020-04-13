# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :ordered_chronologically, -> { order(created_at: :asc) }

  paginates_per 20
  max_paginates_per 100
end
