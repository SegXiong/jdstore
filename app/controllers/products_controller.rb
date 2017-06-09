class ProductsController < ApplicationController
  before_action :authenticate_user!, :only => [:collect, :discollect]
  layout 'index', :only => :index
  before_action :validate_search_key, :only => [:search]

  def index
    if params[:category].blank?
      if params[:order] == "by_price"
        @products = Product.published.order("price ASC").paginate(:page => params[:page], :per_page => 12 )
      elsif params[:order] == "by_popularity"
        @products = Product.published.order("quantity ASC").paginate(:page => params[:page], :per_page => 12 )
      else
        @products = Product.published.recent.paginate(:page => params[:page], :per_page => 12 )
      end
    else
      if params[:order] == "by_price"
        @category_id = Category.find_by(name: params[:category]).id
        @products = Product.published.where(:category_id => @category_id).order("price ASC").paginate(:page => params[:page], :per_page => 12 )
      elsif params[:order] == "by_popularity"
        @category_id = Category.find_by(name: params[:category]).id
        @products = Product.published.where(:category_id => @category_id).order("quantity ASC").paginate(:page => params[:page], :per_page => 12 )
      else
        @category_id = Category.find_by(name: params[:category]).id
        @products = Product.published.where(:category_id => @category_id).recent.paginate(:page => params[:page], :per_page => 12 )
      end
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
    @reviews = @product.reviews.all.paginate(:page => params[:page], :per_page => 10 )

    if @product.is_hidden
      flash[:warning] = t("hidden")
      redirect_to root_path

    end

    set_page_title @product.title
    set_page_description @product.description
    set_page_image @photos.first.avatar.thumb.url

  end

  def add_to_cart
    @product = Product.find_by_friendly_id!(params[:id])
    @quantity = params[:quantity].to_i
    if current_cart.products.include?(@product)
      flash[:warning] = t("alredy-in-cart")
    elsif @quantity <= @product.quantity
      current_cart.add_product_to_cart(@product, @quantity)
      flash[:notice] = t("add-in-cart")
    else
      flash[:warning] = t("out-range")
    end
    redirect_to :back

  end

  def collect
    @product = Product.find_by_friendly_id!(params[:id])
    if !current_user.has_collected?(@product)
      current_user.collect!(@product)
      flash[:notice] = t("collected")
    else
      flash[:warning] = t("already-collected")

    end
    redirect_to :back

  end

  def discollect
    @product = Product.find_by_friendly_id!(params[:id])
    if current_user.has_collected?(@product)
      current_user.discollect!(@product)
      flash[:notice] = t("discollected")
    else
      flash[:warning] = t("already-discollected")

    end
    redirect_to :back

  end

  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(:distinct => true)
      @products = search_result.paginate(:page => params[:page], :per_page => 20)

    end

  end

  private

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)

  end

  def search_criteria(query_string)
    {title_or_description_cont: query_string}

  end
end
