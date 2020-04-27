# frozen_string_literal: true

class PostsCarrier
  def initialize(posts_scope, page: nil)
    @page = page || 1
    @posts_scope = posts_scope.page(page)
  end

  def page_scope
    @posts_scope
  end

  def total_count
    @posts_scope.count
  end

  def cache_key
    {
      resource: 'posts',
      page: @page,
      count: @posts_scope.count,
      last_modified: @posts_scope.maximum(:updated_at)
    }
  end

  def to_hash
    {
      data: posts.map(&:to_hash),
      meta: {
        total_count: @posts_scope.total_count
      }
    }
  end

  def serialized_json
    options = {
      meta: { total_count: @posts_scope.total_count }
    }
    PostSerializer.new(@posts_scope, options).serialized_json
  end

  private

  def posts
    @posts_scope.map { |post| PostCarrier.new(post) }
  end
end
