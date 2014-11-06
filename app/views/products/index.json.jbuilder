json.array!(@products) do |product|
  json.extract! product, :id, :sku, :wholesale_price, :inventory
  json.url product_url(product, format: :json)
end
