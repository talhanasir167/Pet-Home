class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    @products = @products.where("name ILIKE :q OR description ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    @products = @products.where(category: params[:category]) if params[:category].present?
    render :index
  end

  # GET /products/:id
  def show
    render :show
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      render :show, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /products/:id
  def update
    if @product.update(product_params)
      render :show, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :image_url)
  end
end
