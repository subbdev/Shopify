json.array!(@products) do |product|
  json.extract! product, :id, :title, :body_html, :vendor, :product_type
  json.url product_url(product, format: :json)
end
