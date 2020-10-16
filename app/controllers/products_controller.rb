class ProductsController < ApplicationController
  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def update
  end

  def show
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :price, :trading_status,images_attributes: [:image]).merge(user_id: current_user.id)
  end
end
