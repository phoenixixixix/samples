json.collection do
  json.data @comments_carrier.data do |comment|
    json.extract! comment, :id, :body, :created_at
    json.created_by do
      json.id comment.user_id
      json.name comment.user.name
    end
  end

  json.total_pages @comments_carrier.total_pages
  json.current_page @comments_carrier.current_page
end

