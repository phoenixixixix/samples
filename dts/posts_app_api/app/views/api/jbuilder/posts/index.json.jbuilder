json.data @posts_carrier.page_scope do |post|
  json.id post.id
  json.type 'post'
  json.attributes do
    json.extract! post, :body, :likes_count
    json.published_at post.created_at
  end
end

json.meta do
  json.total_count @posts_carrier.total_count
end
