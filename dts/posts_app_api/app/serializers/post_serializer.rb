# frozen_string_literal: true

class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :body, :likes_count
  cache_options enabled: true, cache_length: 2.hours
  attribute :published_at, &:created_at
end
