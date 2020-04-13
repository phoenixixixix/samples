json.collection do
  json.data @posts_carrier.data do |post|
    json.extract! post, :id, :body, :likes_count
    json.published_at post.created_at
    json.liked_by_me post.liked_by_me?
  end

  json.total_pages @posts_carrier.total_pages
  json.current_page @posts_carrier.current_page
end
