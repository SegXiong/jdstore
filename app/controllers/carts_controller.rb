class CartsController < ApplicationController
  before_action :authenticate_user!, :only => [:checkout]
  def clean
    current_cart.clean!
    flash[:warning] = t("clean-out")
    redirect_to carts_path

  end

  def checkout
    @order = Order.new

  end
end
