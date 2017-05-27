class Account::FavoritesController < ApplicationController

  before_action :authenticate_user!

  def index
    @products = current_user.collected_products

  end

  def remove
    @product = Product.find_by_friendly_id!(params[:id])
    current_user.discollect!(@product)
    redirect_to :back

  end
end
