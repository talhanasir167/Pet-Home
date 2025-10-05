## Environment Variables

```
DEVISE_JWT_SECRET_KEY=change-me
STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx
STRIPE_SUCCESS_URL=http://localhost:3001/order-confirmation
STRIPE_CANCEL_URL=http://localhost:3001/cart
SMTP_ADDRESS=localhost
SMTP_PORT=1025
SMTP_DOMAIN=localhost
MAILER_FROM=no-reply@example.com
```

## Endpoints

- Auth: `POST /users` (register), `POST /users/sign_in`, `DELETE /users/sign_out`
- Products: `GET /products`, `GET /products/:id` (others auth-required)
- Orders: `GET /orders`, `GET /orders/:id`, `POST /orders`
- Payments: `POST /payments/checkout_session`, `POST /payments/webhook`

# Pet Products API

A Ruby on Rails API-only application for managing and browsing pet-related products through JSON endpoints. It supports full CRUD operations, search and filter capabilities, and cross-origin requests.

## Technologies

- Ruby 3.1.4 (or later)
- Rails 7.2.x
- PostgreSQL
- Jbuilder for JSON views
- Rack-Cors for cross-origin resource sharing

## Prerequisites

- Ruby >= 3.1.4
- Bundler (`gem install bundler`)
- PostgreSQL (running locally or accessible remotely)
- curl or Postman for API testing

## Setup

1. **Clone the repository**
   ```bash
   git clone <repository_url>
   cd pet_products_api
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Configure the database**
   Edit `config/database.yml` to set your database credentials if needed.

4. **Create and migrate the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Seed the database**
   ```bash
   rails db:seed
   ```

6. **Start the Rails server**
   ```bash
   rails server -p 3000
   ```
   The API will be available at `http://localhost:3000`.

## API Endpoints

### List Products

`GET /products`

- Returns a list of all products in JSON format.
- Optional query parameters:
  - `q` — filters by name or description (case-insensitive).
  - `category` — filters by exact category.

**Example**
```bash
curl http://localhost:3000/products?q=dog&category=Toys
```

### Show a Product

`GET /products/:id`

- Returns a single product by ID.
- Returns `404 Not Found` if the product does not exist.

**Example**
```bash
curl http://localhost:3000/products/1
```

### Create a Product

`POST /products`

- Creates a new product.
- Expects JSON payload with a `product` root:
  ```json
  {
    "product": {
      "name": "Dog Chew Toy",
      "description": "Durable rubber chew toy for dogs.",
      "price": 9.99,
      "category": "Toys",
      "image_url": "https://example.com/images/dog_chew_toy.jpg"
    }
  }
  ```
- Returns `201 Created` with the newly created product JSON on success.
- Returns `422 Unprocessable Entity` with validation errors on failure.

### Update a Product

`PUT /products/:id` or `PATCH /products/:id`

- Updates an existing product with the same payload format as **Create**.
- Returns `200 OK` with updated product JSON on success.
- Returns `422 Unprocessable Entity` on validation failure.

### Delete a Product

`DELETE /products/:id`

- Deletes the specified product.
- Returns `204 No Content` on success.

## JSON Views

- **index.json.jbuilder** — renders a list of products.
- **show.json.jbuilder** — renders a single product.
- **_product.json.jbuilder** — partial used by both index and show.

## Validations

- `name`, `description`, `category`, `image_url` — must be present.
- `price` — numeric, greater than or equal to 0.
- `image_url` — valid HTTP/HTTPS URL.

## Error Handling

- `404 Not Found` with `{ "error": "Message" }` when a record is not found.
- `422 Unprocessable Entity` with `{ "errors": ["...messages..."] }` on validation errors.

## Running Tests

```bash
rails test
```

## Future Enhancements

- Shopping cart and checkout
- User authentication and order history
- Favorites (Wishlist)
- Product reviews and ratings
- Email notifications

---
