class PaymentsController < ApplicationController
  before_action :authenticate_user!, except: [:webhook]

  def create_checkout_session
    order = current_user.orders.includes(order_items: :product).find(params[:order_id])

    line_items = order.order_items.map do |item|
      {
        price_data: {
          currency: 'usd',
          product_data: { name: item.product.name },
          unit_amount: (item.price * 100).to_i
        },
        quantity: item.quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: line_items,
      success_url: ENV['STRIPE_SUCCESS_URL'] || 'http://localhost:3001/order-confirmation?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: ENV['STRIPE_CANCEL_URL'] || 'http://localhost:3001/cart',
      metadata: { order_id: order.id, user_id: current_user.id }
    )

    order.update!(payment_provider: 'stripe', payment_reference: session.id)

    render json: { id: session.id, url: session.url }
  end

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    event = nil
    begin
      if endpoint_secret.present?
        event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
      else
        event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
      end
    rescue JSON::ParserError => e
      return render json: { error: 'Invalid payload' }, status: 400
    rescue Stripe::SignatureVerificationError => e
      return render json: { error: 'Signature verification failed' }, status: 400
    end

    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      order_id = session.metadata&.order_id
      if order_id
        order = Order.find_by(id: order_id)
        if order&.update(status: 'paid')
          OrderMailer.with(order: order).payment_succeeded.deliver_later
        end
      end
    when 'checkout.session.expired', 'payment_intent.payment_failed'
      session = event.data.object
      order_id = session.respond_to?(:metadata) ? session.metadata&.order_id : nil
      if order_id
        order = Order.find_by(id: order_id)
        if order&.update(status: 'failed')
          OrderMailer.with(order: order).payment_failed.deliver_later
        end
      end
    end

    head :ok
  end
end


