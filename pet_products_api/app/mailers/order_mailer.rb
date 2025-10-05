class OrderMailer < ApplicationMailer
  default from: ENV['MAILER_FROM'] || 'no-reply@example.com'

  def order_placed
    @order = params[:order]
    mail(to: recipient_email_for(@order), subject: 'Your order has been placed')
  end

  def payment_succeeded
    @order = params[:order]
    mail(to: recipient_email_for(@order), subject: 'Payment received - Thank you!')
  end

  def payment_failed
    @order = params[:order]
    mail(to: recipient_email_for(@order), subject: 'Payment failed - Action needed')
  end

  def status_updated
    @order = params[:order]
    mail(to: recipient_email_for(@order), subject: "Order status updated: #{@order.status}")
  end

  private

  def recipient_email_for(order)
    order.user&.email || params[:email] || 'user@example.com'
  end
end


