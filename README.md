# Pet Products E-commerce Platform

A full-stack e-commerce platform for pet products with user authentication, online payments, and email notifications.

## Features

### Phase 1 (Completed)
- Product catalog with CRUD operations
- RESTful API with JSON responses
- CORS-enabled for frontend integration

### Phase 2 (Completed)
- **User Authentication**: JWT-based auth with Devise
- **Online Payments**: Stripe Checkout integration
- **Email Alerts**: Order notifications via Action Mailer
- **Order Management**: User accounts with order history

## Tech Stack

### Backend
- **Ruby on Rails 7.2** - API-only application
- **PostgreSQL** - Database
- **Devise + JWT** - Authentication
- **Stripe** - Payment processing
- **Action Mailer** - Email notifications

### Frontend
- **Next.js 14** - React framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling

## Project Structure

```
pet_products_api/          # Rails API backend
├── app/
│   ├── controllers/       # API controllers
│   ├── models/           # Data models
│   ├── mailers/          # Email templates
│   └── views/            # JSON responses
├── config/               # Rails configuration
└── db/                   # Database migrations

pet_products_frontend/     # Next.js frontend
├── src/app/              # App router pages
│   ├── login/            # Authentication pages
│   ├── register/
│   ├── orders/           # Order management
│   └── checkout/         # Payment flow
└── public/               # Static assets
```

## Quick Start

### Prerequisites
- Ruby 3.1+
- Node.js 18+
- PostgreSQL
- Stripe account
- Email service (SendGrid/Postmark)

### Backend Setup

1. **Navigate to API directory**
   ```bash
   cd pet_products_api
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```

4. **Configure environment variables**
   Create `.env` file:
   ```bash
   DEVISE_JWT_SECRET_KEY=your-secret-key-here
   STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
   STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
   STRIPE_SUCCESS_URL=http://localhost:3001/order-confirmation
   STRIPE_CANCEL_URL=http://localhost:3001/cart
   SMTP_ADDRESS=your-smtp-server
   SMTP_PORT=587
   SMTP_DOMAIN=your-domain.com
   MAILER_FROM=noreply@your-domain.com
   ```

5. **Start the server**
   ```bash
   bin/rails server
   ```
   API will be available at `http://localhost:3000`

### Frontend Setup

1. **Navigate to frontend directory**
   ```bash
   cd pet_products_frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   Create `.env.local` file:
   ```bash
   NEXT_PUBLIC_API_BASE_URL=http://localhost:3000
   ```

4. **Start the development server**
   ```bash
   npm run dev
   ```
   Frontend will be available at `http://localhost:3001`

## API Endpoints

### Authentication
- `POST /users` - Register new user
- `POST /users/sign_in` - Login
- `DELETE /users/sign_out` - Logout

### Products
- `GET /products` - List all products
- `GET /products/:id` - Get product details
- `POST /products` - Create product (authenticated)
- `PUT /products/:id` - Update product (authenticated)
- `DELETE /products/:id` - Delete product (authenticated)

### Orders
- `GET /orders` - List user orders (authenticated)
- `GET /orders/:id` - Get order details (authenticated)
- `POST /orders` - Create new order (authenticated)

### Payments
- `POST /payments/checkout_session` - Create Stripe checkout session
- `POST /payments/webhook` - Stripe webhook endpoint

## Frontend Pages

- `/` - Home page
- `/products` - Product catalog
- `/login` - User login
- `/register` - User registration
- `/logout` - User logout
- `/cart` - Shopping cart
- `/checkout` - Checkout process
- `/orders` - User order history
- `/orders/[id]` - Order details
- `/order-confirmation` - Payment success page

## Stripe Integration

### Setup
1. Create a Stripe account
2. Get your API keys from the Stripe dashboard
3. Set up webhook endpoint: `http://your-domain.com/payments/webhook`
4. Configure webhook events:
   - `checkout.session.completed`
   - `checkout.session.expired`
   - `payment_intent.payment_failed`

### Testing
Use Stripe test cards:
- Success: `4242 4242 4242 4242`
- Decline: `4000 0000 0000 0002`

## Email Configuration

The system sends emails for:
- Order placed confirmation
- Payment success notification
- Payment failure alert
- Order status updates

Configure your SMTP settings in the backend environment variables.

## Development

### Running Tests
```bash
# Backend tests
cd pet_products_api
bin/rails test

# Frontend tests
cd pet_products_frontend
npm test
```

### Database Management
```bash
# Reset database
bin/rails db:drop db:create db:migrate db:seed

# Create new migration
bin/rails generate migration CreateNewTable
```

## Deployment

### Backend (Rails API)
- Deploy to Heroku, Railway, or similar platform
- Set environment variables in production
- Configure database connection
- Set up Stripe webhook URL

### Frontend (Next.js)
- Deploy to Vercel, Netlify, or similar platform
- Set `NEXT_PUBLIC_API_BASE_URL` to production API URL
- Configure build settings

## Security Considerations

- JWT tokens are stored in localStorage (consider httpOnly cookies for production)
- API endpoints are protected with authentication
- Stripe webhook signature verification
- CORS configuration for cross-origin requests
- Input validation and sanitization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For questions or issues, please create an issue in the repository or contact the development team.
