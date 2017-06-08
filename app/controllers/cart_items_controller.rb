class CartItemsController < ApplicationController
  #before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    flash[:warning] = t("item-deleted")
    redirect_to :back

  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])

    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = t("quantity-changed")
    else
      flash[:warning] = t("out-range")

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
      redirect_to :back, alert: t("out-range")

    end

  end

  def minus
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
      redirect_to carts_path
    elsif @cart_item.quantity == 1
      redirect_to :back, alert: t("least-one")

    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)

  end
end
