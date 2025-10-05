class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  def index
    orders = current_user.orders.includes(order_items: :product).order(created_at: :desc)
    render :index, locals: { orders: orders }
  end

  def show
    render :show, locals: { order: @order }
  end

  def create
    order = current_user.orders.new(order_params)
    order.status = 'pending'

    if order.save
      OrderMailer.with(order: order).order_placed.deliver_later
      render :show, locals: { order: order }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = current_user.orders.includes(order_items: :product).find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :payment_provider,
      :payment_reference,
      order_items_attributes: [:product_id, :quantity, :price]
    )
  end
end


