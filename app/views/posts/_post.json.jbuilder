json.extract! post, :id, :image, :body, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
json.image do
  json.array!(post.image) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
json.body post.body.to_s
