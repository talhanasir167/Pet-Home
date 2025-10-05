json.extract! order, :id, :status, :total_amount, :payment_provider, :payment_reference, :created_at
json.items order.order_items do |item|
  json.extract! item, :id, :quantity, :price
  json.product do
    json.extract! item.product, :id, :name, :price, :category, :image_url
  end
end

