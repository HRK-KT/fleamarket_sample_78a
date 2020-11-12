class ProductsController < ApplicationController
  require 'payjp'
  before_action :set_product, only: [:show, :destroy, :edit, :update, :purchase_check, :purchase_completed]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new

    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def edit
    @product.images.new
    
    @category_parent_array = ["---"]
    @category_parent_array = Category.where(ancestry: nil)
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      redirect_to action: :edit
    end
  end

  def create
     @product = Product.new(product_params)
     if @product.save
       redirect_to root_path
     else
       @product.images.new
       render :new
     end
  end

  def show
    @product_s = Product.find(params[:id])
  end

  def destroy
    flash.now[:alert] = '削除に失敗しました' unless @product.destroy  
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  # 購入確認ページへ遷移
  def purchase_check
    @product_s = Product.find(params[:id])
    creditcard = Creditcard.where(user_id: current_user.id).last
    if creditcard.blank?
      redirect_to controller: "creditcards", action: "new"
    else
      Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
      customer = Payjp::Customer.retrieve(creditcard.customer_id)
      @default_card_information = customer.cards.retrieve(creditcard.card_id)
    end
  end

  # 購入完了ページに遷移
  def purchase_completed
    @product_s = Product.find(params[:id])
    creditcard = Creditcard.where(user_id: current_user.id).last
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    Payjp::Charge.create(
    :amount => @product_s.price,
    :customer => creditcard.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    @product.update(trading_status: 2)
    redirect_to done_product_path(@product)
  
  end

  def done
    @product_s = Product.find(params[:id])
    creditcard = Creditcard.where(user_id: current_user.id).last
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    customer = Payjp::Customer.retrieve(creditcard.customer_id)
    @default_card_information = customer.cards.retrieve(creditcard.card_id)
  end
  
  private

  def set_product
    # レコードの存在を確認し、なければnot_foundを返す
    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
    else
      redirect_to not_found_path
    end  
  end

  def product_params
    params.require(:product).permit(:product_name, :product_detail, :category_id, :brand, :delivery_area, :price, :size_id, :product_status_id, :delivery_fee_id, :delivery_time_id, :trading_status,images_attributes: [:image, :id, :_destory]).merge(user_id: current_user.id)
  end
end
