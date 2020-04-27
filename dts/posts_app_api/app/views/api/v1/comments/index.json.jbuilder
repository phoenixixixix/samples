json.collection do
  json.data @comments_carrier.comments do |comment|
    json.extract! comment, :id, :body, :created_at
    json.created_by do
      json.id comment.user_id
      json.name comment.user.name
    end
  end

  json.total_count @comments_carrier.total_count
end

