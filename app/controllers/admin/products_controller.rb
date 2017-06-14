class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout "admin"

  def index
    @products = Product.all.paginate(:page => params[:page], :per_page => 8 )

  end

  def new
    @product = Product.new
    @photo = @product.photos.build
    @river_pic = @product.river_pics.build

  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:photos] != nil
        params[:photos]['avatar'].each do |a|
          @photo = @product.photos.create(:avatar => a)
        end

      end
      if params[:river_pics] != nil
        params[:river_pics]['rvatar'].each do |r|
          @river_pic = @product.river_pics.create(:rvatar => r)
        end

      end
      redirect_to admin_products_path
    else
      render :new

    end

  end

  def edit
    @product = Product.find_by_friendly_id!(params[:id])

  end

  def update
    @product = Product.find_by_friendly_id!(params[:id])
    if params[:photos] != nil
      @product.photos.destroy_all
      params[:photos]['avatar'].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end
    end
    if params[:river_pics] != nil
      @product.river_pics.destroy_all
      params[:river_pics]['rvatar'].each do |r|
        @rpic = @product.river_pics.create(:rvatar => r)
      end
    end
    @product.update(product_params)
    redirect_to admin_products_path

  end

  def destroy
    @product = Product.find_by_friendly_id!(params[:id])
    @product.destroy
    redirect_to admin_products_path

  end

  def publish
    @product = Product.find_by_friendly_id!(params[:id])
    @product.publish!
    redirect_to :back

  end

  def hide
    @product = Product.find_by_friendly_id!(params[:id])
    @product.hide!
    redirect_to :back

  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :friendly_id, :category_id, :is_hidden)

  end
end
