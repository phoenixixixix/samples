# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rate, presence: true, inclusion: 1..10
end
