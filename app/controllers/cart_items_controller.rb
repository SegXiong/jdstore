class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    flash[:warning] = "成功将 #{@product.title} 从购物车删除！"
    redirect_to :back

  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])

    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = "成功变更数量"
    else
      flash[:warning] = "数量不足以加入购物车"

    end

    redirect_to carts_path

  end

  def add
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity < @cart_item.product.quantity
      @cart_item.quantity += 1
      @cart_item.save
      redirect_to carts_path
    elsif @cart_item.quantity == @cart_item.product.quantity
      redirect_to :back, alert: "Out of Storage"

    end

  end

  def minus
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
      redirect_to carts_path
    elsif @cart_item.quantity == 1
      redirect_to :back, alert: "At least One"

    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)

  end
end
