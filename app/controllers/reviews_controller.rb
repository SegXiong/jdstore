class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required, :only => [:destroy]

  def new
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.new
    @review_pic = @review.review_pics.build

  end

  def create
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    if @review.save
      if params[:review_pics] != nil
        params[:review_pics]['avatar'].each do |a|
          @review_pic = @review.review_pics.create(:avatar => a)
        end

      end
      redirect_to product_path(@product)
    else
      render :new

    end

  end

  def destroy
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)

  end

  def like
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.find(params[:id])
    unless @review.find_like(current_user)
      Like.create(:user_id => current_user.id, :review_id => @review.id)

    end
    redirect_to product_path(@product)

  end

  def unlike
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.find(params[:id])
    like = @review.find_like(current_user)
    like.destroy
    redirect_to product_path(@product)

  end

  private

  def review_params
    params.require(:review).permit(:content, :rate)

  end
end
