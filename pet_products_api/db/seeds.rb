# This file populates the database with sample pet products.
# Run with `bin/rails db:seed`.

products = [
  { name: 'Dog Chew Toy', description: 'Durable rubber chew toy for dogs.', price: 9.99, category: 'Toys', image_url: 'https://example.com/images/dog_chew_toy.jpg' },
  { name: 'Cat Scratching Post', description: 'Sturdy scratching post for cats with sisal rope.', price: 24.99, category: 'Toys', image_url: 'https://example.com/images/cat_scratching_post.jpg' },
  { name: 'Bird Cage', description: 'Spacious cage suitable for small to medium birds.', price: 79.49, category: 'Accessories', image_url: 'https://example.com/images/bird_cage.jpg' },
  { name: 'Fish Tank', description: '20-gallon glass fish tank with LED lighting.', price: 129.99, category: 'Aquarium', image_url: 'https://example.com/images/fish_tank.jpg' },
  { name: 'Dog Leash', description: 'Nylon leash with padded handle.', price: 14.99, category: 'Accessories', image_url: 'https://example.com/images/dog_leash.jpg' },
  { name: 'Cat Bed', description: 'Soft plush bed for cats.', price: 19.99, category: 'Accessories', image_url: 'https://example.com/images/cat_bed.jpg' },
  { name: 'Hamster Wheel', description: 'Silent spinning wheel for hamsters.', price: 12.5, category: 'Toys', image_url: 'https://example.com/images/hamster_wheel.jpg' },
  { name: 'Rabbit Hutch', description: 'Outdoor rabbit hutch with ramp and shelter.', price: 199.00, category: 'Housing', image_url: 'https://example.com/images/rabbit_hutch.jpg' },
  { name: 'Bird Feeder', description: 'Weatherproof bird feeder.', price: 29.99, category: 'Accessories', image_url: 'https://example.com/images/bird_feeder.jpg' },
  { name: 'Cat Food', description: 'Premium chicken-flavored cat food.', price: 39.99, category: 'Food', image_url: 'https://example.com/images/cat_food.jpg' }
]

products.each do |attrs|
  Product.find_or_create_by!(name: attrs[:name]) do |p|
    p.description = attrs[:description]
    p.price = attrs[:price]
    p.category = attrs[:category]
    p.image_url = attrs[:image_url]
  end
end

puts "Seeded #{Product.count} products"
