# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :post, optional: false, counter_cache: true

  validates :post, uniqueness: { scope: :user }
end
