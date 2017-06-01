class ProductsController < ApplicationController
  def index
    if params[:category].blank?
      @products = Product.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(:category_id => @category_id)
    end

  end

  def show
    @product = Product.find_by_friendly_id!(params[:id])
    @photos = @product.photos.all
    @river_pics = @product.river_pics.all
    @reviews = @product.reviews.all
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rate).present? ? @reviews.average(:rate).round(2) : 0
    end

  end

  def add_to_cart
    @product = Product.find_by_friendly_id!(params[:id])
    @quantity = params[:quantity].to_i
    if current_cart.products.include?(@product)
      flash[:warning] = "你的购物车内已有此物品"
    elsif @quantity <= @product.quantity
      current_cart.add_product_to_cart(@product, @quantity)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "选择的商品数量超过库存"
    end
    redirect_to :back

  end

  def collect
    @product = Product.find_by_friendly_id!(params[:id])
    if !current_user.has_collected?(@product)
      current_user.collect!(@product)
      flash[:notice] = "Item collected"
    else
      flash[:warning] = "You've already collected"

    end
    redirect_to :back

  end

  def discollect
    @product = Product.find_by_friendly_id!(params[:id])
    if current_user.has_collected?(@product)
      current_user.discollect!(@product)
      flash[:notice] = "Item discollected"
    else
      flash[:warning] = "You haven't collected yet"

    end
    redirect_to :back

  end
end
